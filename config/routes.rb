MorethingsneedTo::Application.routes.draw do
  resources :entries, except: [:new, :edit]

  match "auth/:provider/callback", to: "authentications#create"
  match "auth/failure", to: redirect("/")

  match "login", to: "identities#login", as: :login
  match "register", to: "identities#register", as: :register
  match "logout", to: "sessions#destroy", as: :logout

  root to: "entries#index"
end
