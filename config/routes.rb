ActionController::Routing::Routes.draw do |map|
  map.resources :entries, :except => [:new, :edit], :collection => { :show_spam => :get }, :member => { :toggle_spam => :put } do |entry|
    entry.resources :comments, :only => [:create, :destroy], :member => { :toggle_spam => :put }
    entry.resources :votes, :only => [:create, :destroy] 
  end
  
  map.about '/about', :controller => 'pages', :action => 'about'
  map.faq '/faq', :controller => 'pages', :action => 'faq'
  map.privacy '/privacy', :controller => 'pages', :action => 'privacy'
  map.resources :contact, :only => [:index, :new, :create]

  map.register '/register', :controller => :users, :action => 'new'
  map.profile '/profile', :controller => :users, :action => 'edit'
  map.resources :activations, :only => [:new, :create]
  map.activate '/activate/:activation_code', :controller => 'activations', :action => 'activate'
  map.resources :password_resets, :only => [:new, :edit, :create, :update]

  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  
  map.entry_id '/:id', :controller => 'entries', :action => 'show', :requirements => { :id => /\d+/} 

  map.resources :users, :only => [:new, :create, :edit, :update] do |user|
    user.resources :entries, :only => [:index]
  end
  map.resources :user_sessions, :only => [:new, :create, :destroy]

  map.root :entries
end