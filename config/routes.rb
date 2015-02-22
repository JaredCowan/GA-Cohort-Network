Rails.application.routes.draw do

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :activities
  resources :statuses
  resources :questions
  resources :posts
  resources :jobs
  
  root :to => 'static_pages#dashboard'

  match '/signup',                to: 'users#new',                   via: 'get'
  match '/users/:id/edit',        to: 'users#edit',                  via: 'get'
  match '/signin',                to: 'sessions#new',                via: 'get'
  match '/signout',               to: 'sessions#destroy',            via: 'delete'
  match '/home',                  to: 'static_pages#home',           via: 'get'
  match '/dashboard',             to: 'static_pages#dashboard',      via: 'get'
  match '/jobs',                  to: 'jobs#index',                  via: 'get'
  match '/newjobs',               to: 'jobs#new',                    via: 'get'
  match '/user_questions',        to: 'static_pages#user_questions', via: 'get'
  match '/user_statuses',         to: 'static_pages#user_statuses',  via: 'get'
  match '/statuses',              to: 'statuses#upvote',             via: 'put'
  match '/statuses/:id/like',     to: 'statuses#upvote',             via: 'put'
  match '/statuses/:id/dislike',  to: 'statuses#downvote',           via: 'put'
  match '/jobs',                  to: 'jobs#upvote',                 via: 'put'
  match '/comments/new',          to: 'comments#new',                via: "[:get, :post, :put]", as: :comment_path
  match '/comments',              to: 'comments#create',             via: "[:get, :POST, :put]"
  match '/jobs/:id/like',         to: 'jobs#upvote',                 via: 'put'
  match '/jobs/:id/dislike',      to: 'jobs#downvote',               via: 'put'
  get   'questions/tags/:tag',    to: 'questions#index',              as: :tag

  resources :comments

  resources :statuses do 
    resources :comments
  end

  scope '/hooks', :controller => :hook do
    post :comment
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
  
  # scope ":user_name" do
  #   resources :albums do
  #     resources :pictures
  #   end
  # end

  # get '/:id', to: 'profiles#show', as: 'profile'

  scope "/users/:id" do
    resources :albums do
      resources :pictures
    end
  end

  match '/:user_name', to: 'users#show', via: "get"
  match '/friends',    to: 'user_friendships#index', as: :friends, via: "[:get, :post]"
  get '/forum',        to: 'statuses#index',         as: :forum
  get '/profile/:id',  to: 'profiles#show',          as: :profile_page

  # Handle routing errors
  ## NEVER PUT ROUTES BELOW THIS LINE
  match "*path", to: 'application#routing_error',   via: 'get'
end
