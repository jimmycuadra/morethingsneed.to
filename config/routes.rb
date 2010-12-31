Morethingsneed::Application.routes.draw do
  resources :entries, :except => [:new] do
    put 'toggle_spam', :on => :member
    get 'show_spam', :on => :collection
    
    resources :comments, :only => [:create, :destroy] do
      put 'toggle_spam', :on => :member
    end
    
    resources :votes, :only => [:create, :destroy]
  end
  
  match '/about' => 'pages#about', :as => 'about'
  match '/faq' => 'pages#faq', :as => 'faq'
  match '/privacy' => 'pages#privacy', :as => 'privacy'
  resources :contact, :only => [:index, :new, :create]

  match '/register' => 'users#new', :as => 'register'
  match '/profile' => 'users#edit', :as => 'profile'
  resources :activations, :only => [:new, :create]
  match '/activate/:activation_code'=> 'activations#activate', :as => 'activate'
  resources :password_resets, :only => [:new, :edit, :create, :update]

  match '/login' => 'user_sessions#new', :as => 'login'
  match '/logout' => 'user_sessions#destroy', :as => 'logout'
  
  match '/:id' => 'entries#show', :constraints => { :id => /\d+/}, :as => 'entry_id'

  resources :users, :only => [:index, :new, :create, :edit, :update] do
    resources :entries, :only => [:index]
  end
  resources :user_sessions, :only => [:new, :create, :destroy]

  root :to => 'entries#index'
end
