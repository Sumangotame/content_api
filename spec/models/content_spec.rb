require 'rails_helper'

RSpec.describe Content, type: :model do
  describe "validations" do
    it "validates the presence of title" do
      content = build(:content, title: nil)
      expect(content).not_to be_valid
      expect(content.errors[:title]).to include("can't be blank")
    end

    it "validates the presence of body" do
      content = build(:content, body: nil)
      expect(content).not_to be_valid
      expect(content.errors[:body]).to include("can't be blank")
    end

    it "validates the presence of user association" do
      content = build(:content, user: nil)
      expect(content).not_to be_valid
      expect(content.errors[:user]).to include("must exist")
    end
  end
end

