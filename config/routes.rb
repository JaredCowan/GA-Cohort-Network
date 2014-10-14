Rails.application.routes.draw do
  
  get 'posts/index'

  get 'posts/show'

  get 'posts/edit'

  get 'posts/new'

  get 'posts/create'

  get 'posts/destroy'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :activities
  resources :statuses
  resources :questions
  
  root :to => 'static_pages#dashboard'

  match '/signup',           to: 'users#new',                   via: 'get'
  match '/users/:id/edit',   to: 'users#edit',                  via: 'get'
  match '/signin',           to: 'sessions#new',                via: 'get'
  match '/signout',          to: 'sessions#destroy',            via: 'delete'
  match '/home',             to: 'static_pages#home',           via: 'get'
  match '/dashboard',        to: 'static_pages#dashboard',      via: 'get'
  match '/jobs',             to: 'jobs#index',                  via: 'get'
  match '/newjobs',          to: 'jobs#new',                    via: 'get'
  match '/user_questions',   to: 'static_pages#user_questions', via: 'get'
  match '/user_statuses',    to: 'static_pages#user_statuses',  via: 'get'
  get 'questions/tags/:tag', to: 'questions#index',              as: :tag

  resources :statuses do 
    resources :comments
  end

  resources :questions do 
    resources :answers
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

  resources :questions do
    member do
      put "like", to: "questions#upvote"
      put "dislike", to: "questions#downvote"
    end
  end

  resources :user_friendships do
    member do
      put :accept
      put :block
    end
  end

  scope "/profile/:id" do
    resources :albums do
      resources :pictures
    end
  end

  match '/friends',   to: 'user_friendships#index', as: :friends, via: "get"
  get 'forum',        to: 'statuses#index',         as: :forum
  get '/profile/:id', to: 'profiles#show',          as: :profile_page

  # Handle routing errors
  ## NEVER PUT ROUTES BELOW THIS LINE
  match "*path", to: 'application#routing_error',   via: 'get'
end
