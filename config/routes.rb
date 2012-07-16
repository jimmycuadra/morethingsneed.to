MTNT::Application.routes.draw do
  scope "api" do
    resources :entries
  end

  match "(*path)" => "web#index"
end
