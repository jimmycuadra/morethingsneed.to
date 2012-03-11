MTNT::Application.routes.draw do
  mount Jasminerice::Engine => "/jasmine" unless Rails.env.production?

  scope "api" do
    resources :entries
  end

  match "(*path)" => "web#index"
end
