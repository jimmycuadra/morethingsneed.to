ActionController::Routing::Routes.draw do |map|
  map.resources :entries, :except => [:new, :edit, :update] do |entry|
    entry.resources :comments, :only => [:create, :destroy]
    entry.resources :votes, :only => [:create, :destroy] 
  end
  
  map.resources :contact, :only => [:index, :new, :create]

  map.register '/register', :controller => :users, :action => 'new'
  map.profile '/profile', :controller => :users, :action => 'edit'
  map.activate '/activate/:activation_code', :controller => 'activations', :action => 'create'

  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'

  map.resources :users, :only => [:new, :create, :edit, :update] do |user|
    user.resources :entries, :only => [:index]
  end
  map.resources :user_sessions, :only => [:new, :create, :destroy]

  map.root :entries
end