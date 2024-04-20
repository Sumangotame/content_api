require 'rails_helper'

RSpec.describe Api::V1::ContentsController, type: :controller do
  describe "POST #create" do

    let(:user) { create(:user) }
    it "creates a content when authenticated" do
      token = JWT.encode({ user_id: user.id }, Rails.application.secret_key_base)
      request.headers['Authorization'] = "Bearer #{token}"
      post :create, params: { content: { title: "Test Title", body: "Test Body" } }
      expect(response).to have_http_status(:created)
      expect(Content.count).to eq(1)
    end

    it "returns unauthorized when not authenticated" do
      post :create, params: { content: { title: "Test Title", body: "Test Body" } }
      expect(response).to have_http_status(:unauthorized)
      expect(Content.count).to eq(0)
    end
  end

  describe "GET #index" do

  it "returns a list of contents" do
    contents = create_list(:content, 3) 
    tokens = contents.map { |content| JWT.encode({ user_id: content.user.id }, Rails.application.secret_key_base) }
    request.headers['Authorization'] = "Bearer #{tokens.first}"
    get :index
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)['data'].count).to eq(3)
   end
   it "returns unauthorized to get content" do
    get :index
    expect(response).to have_http_status(:unauthorized)
   end
  end

  describe "PUT #update" do

    let(:content) { create(:content) }
    it "updates a content when authenticated" do
      token = JWT.encode({ user_id: content.user.id }, Rails.application.secret_key_base)
      request.headers['Authorization'] = "Bearer #{token}"
      put :update, params: { id: content.id, content: { title: "Updated Title", body: "Updated Body" } }
      expect(response).to have_http_status(:success)
      expect(Content.find(content.id).title).to eq("Updated Title")
    end

    it "returns unauthorized when not authenticated" do
      put :update, params: { id: content.id, content: { title: "Updated Title", body: "Updated Body" } }
      expect(response).to have_http_status(:unauthorized)
      expect(Content.find(content.id).title).not_to eq("Updated Title")
    end
  end

  describe "DELETE #destroy" do

  let!(:content) { create(:content) }
  it "deletes a content when authenticated" do
    token = JWT.encode({ user_id: content.user.id }, Rails.application.secret_key_base)
    request.headers['Authorization'] = "Bearer #{token}"
    delete :destroy, params: { id: content.id }
    expect(response).to have_http_status(:success)
    expect(Content.where(id: content.id)).to be_empty
  end

  it "returns unauthorized when not authenticated" do
    delete :destroy, params: { id: content.id }
    expect(response).to have_http_status(:unauthorized)
    expect(Content.where(id: content.id)).not_to be_empty
  end
end
end


