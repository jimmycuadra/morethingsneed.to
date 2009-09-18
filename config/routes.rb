ActionController::Routing::Routes.draw do |map|
  map.resources :entries, :except => [:new] do |entry|
    entry.resources :comments, :only => [:create, :destroy]
    entry.resources :votes, :only => [:create, :destroy] 
  end
  map.root :controller => 'entries'
end