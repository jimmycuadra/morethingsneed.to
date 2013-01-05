MorethingsneedTo::Application.routes.draw do
  resources :entries

  match "auth/:provider/callback", to: "authentications#create"
  match "auth/failure", to: redirect("/")

  root to: "entries#index"
end
