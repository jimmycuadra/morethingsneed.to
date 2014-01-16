FactoryGirl.define do
  random_ip = lambda do
    4.times.map { rand(255) }.join('.')
  end

  factory :banned_ip do
    ip random_ip.call
  end

  factory :comment do
    comment "More comments need to be made."
    ip random_ip.call
  end

  factory :entry do
    noun "things"
    needs false
    verb "to"
    ip random_ip.call
  end

  factory :user do
    username "Bongo"
    email "bongo@example.com"
    password "secret"
    password_confirmation "secret"
    active true
  end
end
