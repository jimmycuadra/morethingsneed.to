ActionController::Routing::Routes.draw do |map|
  map.resources :entries, :except => [:new], :has_many => [:comments, :votes]
  map.resources :comments, :only => [:create, :destroy], :belongs_to => :entry
  map.root :controller => 'entries'
end