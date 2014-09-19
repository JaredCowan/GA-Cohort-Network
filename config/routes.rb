Rails.application.routes.draw do

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  
  root :to => 'static_pages#dashboard'
    match '/signup',    to: 'users#new',              via: 'get'
    match '/users/:id/edit',      to: 'users#edit',             via: 'get'
    match '/signin',    to: 'sessions#new',           via: 'get'
    match '/signout',   to: 'sessions#destroy',       via: 'delete'
    match '/home',      to: 'static_pages#home',      via: 'get'
    match '/dashboard', to: 'static_pages#dashboard', via: 'get'

  resources :statuses do 
    resources :comments
  end  
    
  resources :user_friendships do
    member do
      put :accept
      put :block
    end
  end

  resources :statuses
  get 'friends', to: 'user_friendships#index', as: :friends
  get 'forum', to: 'statuses#index', as: :forum
  get '/profile/:id', to: 'profiles#show', as: :profile_page


end
