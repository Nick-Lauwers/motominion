Rails.application.routes.draw do

  root                                'static_pages#home'
  get    'help'                    => 'static_pages#help'
  get    'about'                   => 'static_pages#about'
  get    'how-it-works'            => 'static_pages#how_it_works'
  get    'dashboard'               => 'static_pages#dashboard'
  get    'legal'                   => 'static_pages#legal'
  get    'customers'               => 'appointments#customers'
  get    'test-drives'             => 'appointments#test_drives'
  get    'signup'                  => 'users#new'
  get    'login'                   => 'sessions#new'
  get    'auth/:provider/callback' => 'sessions#create_social'
  post   'login'                   => 'sessions#create'
  delete 'logout'                  => 'sessions#destroy'
  
  resources :photos
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :questions,           only: [:index, :create, :destroy]
  resources :replies,             only: [:create, :destroy]
  resources :enquiries,           only: [:new, :create]
  resources :profiles,            only: [:show, :edit, :update]

  resources :users do
    resources :reviews, only: [:index, :destroy]
  end

  resources :vehicles do
    
    resources :reviews,      only: [:create, :destroy]
    resources :payments,     only: [:new, :create]
    
    # put :favorite, on: :member
    # put :sold,     on: :member
    
    member do
      put :favorite
      put :sold
      put :undo_sold
    end
    
    collection do
      get 'search'
      get :autocomplete
    end
    
    resources :appointments, only: [:new, :create, :destroy] do
      member do
        put :accept
        put :decline
      end
    end
  end

  resources :conversations, only: [:index, :create] do
    
    resources :appointments, only:   [:new, :create, :destroy]
    resources :messages,     except: [:new, :edit, :show, :update]
    
    member do
      put :archive
    end
  end
  
  resources :posts do
    
    resources :responses
    
    member do
      get :like,   to: "posts#like"
      get :unlike, to: "posts#unlike"
    end
    
    collection do
      get 'search'
      get :autocomplete
    end
  end
  
  # match "conversations/:id/messages/accept" => "conversations#messages#accept", :as => "conversation_messages_accept_path"
  
  # match "conversations/:id/messages/decline" => "conversations#messages#decline", :as => "conversation_messages_decline_path"
end