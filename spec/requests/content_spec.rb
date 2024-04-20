require 'rails_helper'

RSpec.describe "Contents", type: :request do
    describe "POST #create" do
  
      let(:user) { create(:user) }
      it "creates a content when authenticated" do
        token = JWT.encode({ user_id: user.id }, Rails.application.secret_key_base)
        post api_v1_contents_path, params: { content: { title: "Test Title", body: "Test Body" } }, headers: { 'Authorization' => "Bearer #{token}" }
        expect(response).to have_http_status(:created)
        expect(Content.count).to eq(1)
      end
  
      it "returns unauthorized when not authenticated" do
        post api_v1_contents_path, params: { content: { title: "Test Title", body: "Test Body" } }
        expect(response).to have_http_status(:unauthorized)
        expect(Content.count).to eq(0)
      end
    end
  
    describe "GET #index" do
  
    it "returns a list of contents" do
      contents = create_list(:content, 3) 
      tokens = contents.map { |content| JWT.encode({ user_id: content.user.id }, Rails.application.secret_key_base) }
      get api_v1_contents_path, headers: { 'Authorization' => "Bearer #{tokens.first}" }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data'].count).to eq(3)
     end
     it "returns unauthorized to get content" do
      post api_v1_contents_path
      expect(response).to have_http_status(:unauthorized)
     end
    end
  
    describe "PUT #update" do
  
      let(:content) { create(:content) }
      it "updates a content when authenticated" do
        token = JWT.encode({ user_id: content.user.id }, Rails.application.secret_key_base)
        put api_v1_content_path(content), params: { content: { title: "Updated Title", body: "Updated Body" } },headers: { 'Authorization' => "Bearer #{token}" }
        expect(response).to have_http_status(:ok)
        expect(Content.find(content.id).title).to eq("Updated Title")
      end
  
      it "returns unauthorized when not authenticated" do
        put api_v1_content_path(content), params: {  content: { title: "Updated Title", body: "Updated Body" } }
        expect(response).to have_http_status(:unauthorized)
        expect(Content.find(content.id).title).not_to eq("Updated Title")
      end
    end
  
    describe "DELETE #destroy" do
  
    let!(:content) { create(:content) }
    it "deletes a content when authenticated" do
      token = JWT.encode({ user_id: content.user.id }, Rails.application.secret_key_base)
      delete api_v1_content_path(content), headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:success)
      expect(Content.where(id: content.id)).to be_empty
    end
  
    it "returns unauthorized when not authenticated" do
      delete api_v1_content_path(content)
      expect(response).to have_http_status(:unauthorized)
      expect(Content.where(id: content.id)).not_to be_empty
    end
  end
  end
