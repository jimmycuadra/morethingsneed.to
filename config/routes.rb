MTNT::Application.routes.draw do
  match "(*path)" => "main#index"
end
