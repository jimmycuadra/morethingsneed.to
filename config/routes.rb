MTNT::Application.routes.draw do
  root :to => "entries#index"

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#failure"
end
