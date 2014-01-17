FactoryGirl.define do
  random_ip = lambda do
    4.times.map { rand(255) }.join('.')
  end

  factory :banned_ip do
    ip { random_ip.call }
  end

  factory :comment do
    sequence(:comment) { |n| "This is comment ##{n}." }
    ip { random_ip.call }
    entry
  end

  factory :entry do
    noun "things"
    needs false
    sequence(:verb) { |n| "to be entry ##{n}" }
    ip { random_ip.call }
  end

  factory :user do
    username "Bongo"
    email "bongo@example.com"
    password "secret"
    password_confirmation "secret"
    active true
  end
end
