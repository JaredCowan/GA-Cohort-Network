Rails.application.routes.draw do
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :activities, only: [:index]
  
  root :to => 'static_pages#dashboard'

  match '/signup',         to: 'users#new',              via: 'get'
  match '/users/:id/edit', to: 'users#edit',             via: 'get'
  match '/signin',         to: 'sessions#new',           via: 'get'
  match '/signout',        to: 'sessions#destroy',       via: 'delete'
  match '/home',           to: 'static_pages#home',      via: 'get'
  match '/dashboard',      to: 'static_pages#dashboard', via: 'get'
  match '/jobs',           to: 'jobs#index',             via: 'get'
  match '/newjobs',        to: 'jobs#new',               via: 'get'

  resources :statuses do 
    resources :comments
  end  
  

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
      post :perm_trash
    end
  end

  resources :lessons
  resources :jobs

  resources :users do
   member do
    get :following
    get :followers
   end
  end

  resources :jobs do
    member do
      put "like", to: "jobs#upvote"
      put "dislike", to: "jobs#downvote"
    end
  end

  resources :activities do
    member do
      put "like", to: "activities#upvote"
      put "dislike", to: "activities#downvote"
    end
  end

  resources :statuses do
    member do
      put "like", to: "statuses#upvote"
      put "dislike", to: "statuses#downvote"
    end
  end

  resources :user_friendships do
    member do
      put :accept
      put :block
    end
  end

  scope ":profile_name" do
    resources :albums do
      resources :pictures
    end
  end

  resources :statuses
  get 'friends',      to: 'user_friendships#index', as: :friends
  get 'forum',        to: 'statuses#index',         as: :forum
  get '/profile/:id', to: 'profiles#show',          as: :profile_page

end
