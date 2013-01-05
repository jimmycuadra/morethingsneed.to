MorethingsneedTo::Application.routes.draw do
  resources :entries

  match "auth/:provider/callback" => "authentications#create"

  root to: "entries#index"
end
