MTNT::Application.routes.draw do
  mount Jasminerice::Engine => "/jasmine" unless Rails.env.production?

  constraints(format: :json) do
    resources :entries
  end

  match "(*path)" => "entries#index"
end
