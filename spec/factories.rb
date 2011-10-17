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

  factory :entry do
    noun "tests"
    verb "be written"
    needs false
    user
  end
end
