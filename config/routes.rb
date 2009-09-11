ActionController::Routing::Routes.draw do |map|
  map.resources :entries, :except => [:new], :has_many => [:comments, :votes]
  map.root :controller => 'entries'
end