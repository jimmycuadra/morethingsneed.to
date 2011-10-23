MTNT::Application.routes.draw do
  root :to => "entries#index"

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#failure"
  match "/logout" => "sessions#destroy", as: :logout

  mount Jasminerice::Engine => "/jasmine" unless Rails.env.production?
end
