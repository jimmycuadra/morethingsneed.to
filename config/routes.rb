MorethingsneedTo::Application.routes.draw do
  resources :entries, except: [:new, :edit] do
    resources :comments, only: [:create, :update, :destroy]
  end

  resources :users, only: [:edit, :update]

  match "auth/:provider/callback", to: "sessions#create"
  match "logout", to: "sessions#destroy"
  match "auth/failure", to: redirect("/")

  resources :sessions, only: :create

  root to: "entries#index"
end
