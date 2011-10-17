FactoryGirl.define do
  factory :user do
    name "Bongo"
    email "bongo@example.com"
  end

  factory :authentication do
    provider "test"
    uid "1234"
    user
  end

  factory :entry do
    noun "tests"
    verb "be written"
    needs false
    user
  end
end
