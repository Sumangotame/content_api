require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "validates the presence of email" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "validates the presence of password" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "validates the presence of first name" do
      user = build(:user, firstName: nil)
      expect(user).not_to be_valid
      expect(user.errors[:firstName]).to include("can't be blank")
    end

    it "validates the presence of last name" do
      user = build(:user, lastName: nil)
      expect(user).not_to be_valid
      expect(user.errors[:lastName]).to include("can't be blank")
    end
  end
end


