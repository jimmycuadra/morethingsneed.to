MTNT::Application.routes.draw do
  mount Jasminerice::Engine => "/jasmine" unless Rails.env.production?

  match "(*path)" => "entries#index"
end
