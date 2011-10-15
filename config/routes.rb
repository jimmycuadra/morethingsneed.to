MTNT::Application.routes.draw do
  root :to => "entries#index"

  match "/auth/:provider/callback" => "sessions#create"
end
