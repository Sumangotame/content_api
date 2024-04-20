FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user_#{n}@example.com"
    end
    password {"suman"}
    firstName {"suman"}
    lastName {"gotame"}
    country {"nepal"}
  end
end
