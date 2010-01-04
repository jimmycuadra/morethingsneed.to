ActionController::Routing::Routes.draw do |map|
  map.resources :entries, :except => [:new, :edit] do |entry|
    entry.resources :comments, :only => [:create, :destroy]
    entry.resources :votes, :only => [:create, :destroy] 
  end
  
  map.about '/about', :controller => 'about', :action => 'index'
  map.resources :contact, :only => [:index, :new, :create]

  map.register '/register', :controller => :users, :action => 'new'
  map.profile '/profile', :controller => :users, :action => 'edit'
  map.activate '/activate/:activation_code', :controller => 'activations', :action => 'create'

  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  
  map.entry_id '/:id', :controller => 'entries', :action => 'show', :requirements => { :id => /\d+/} 

  map.resources :users, :only => [:new, :create, :edit, :update] do |user|
    user.resources :entries, :only => [:index]
  end
  map.resources :user_sessions, :only => [:new, :create, :destroy]

  map.root :entries
end