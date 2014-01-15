FactoryGirl.define do
  random_ip = lambda do
    4.times.map { rand(255) }.join('.')
  end

  factory :banned_ip do
    ip random_ip.call
  end
end
