ActionController::Routing::Routes.draw do |map|
  map.resources :entries, :except => [:new] do |entry|
    entry.resources :comments, :only => [:create, :destroy]
    entry.resources :votes, :only => [:create, :destroy] 
  end
  
  map.resources :users, :user_sessions
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.root :entries
end