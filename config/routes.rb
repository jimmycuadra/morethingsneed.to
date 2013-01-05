MorethingsneedTo::Application.routes.draw do
  resources :entries

  match "auth/:provider/callback", to: "authentications#create"
  match "auth/failure", to: redirect("/")
  match "logout", to: "sessions#destroy", as: :log_out

  root to: "entries#index"
end
