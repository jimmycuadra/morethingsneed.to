FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Bongo #{n}" }
    sequence(:email) { |n| "bongo#{n}@example.com" }
  end

  factory :authentication do
    provider "test"
    sequence(:uid) { |n| n }
    user
  end
end
