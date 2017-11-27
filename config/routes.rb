Rails.application.routes.draw do

  root                                'static_pages#home'
  get    'help'                    => 'static_pages#help'
  get    'about'                   => 'static_pages#about'
  get    'how-it-works'            => 'static_pages#how_it_works'
  get    'dashboard'               => 'static_pages#dashboard'
  get    'legal'                   => 'static_pages#legal'
  get    'customers'               => 'appointments#customers'
  get    'test-drives'             => 'appointments#test_drives'
  get    'purchases_made'          => 'purchases#purchases_made'
  get    'orders_received'         => 'purchases#orders_received'
  get    'payment_method'          => 'users#payment'
  get    'payout_method'           => 'users#payout'
  get    'signup'                  => 'users#new'
  get    'login'                   => 'sessions#new'
  get    'auth/:provider/callback' => 'sessions#create_social'
  post   'add_card'                => 'users#add_card'
  post   'login'                   => 'sessions#create'
  delete 'logout'                  => 'sessions#destroy'
  
  resources :autopart_photos
  resources :account_activations,    only: [:edit]
  resources :dealership_activations, only: [:edit]
  resources :password_resets,        only: [:new, :create, :edit, :update]
  resources :questions,              only: [:index, :create, :destroy]
  resources :answers,                only: [:create, :destroy]
  resources :enquiries,              only: [:new, :create]
  resources :profiles,               only: [:show, :edit, :update]

  resources :vehicle_makes do
    member do
      get 'posts'
      get 'discussions'
    end
  end
  
  resources :clubs do
    
    resources :club_products
    resources :invitations
   
    member do
      
      get 'posts'
      get 'discussions'
      
      put :join
    end
    
    collection do
      get 'search'
      get :autocomplete
    end
  end

  resources :users do
    
    resources :reviews, only: [:index, :destroy]

    member do
      get 'profile_pic'
    end
  end

  resources :vehicles do
    
    resources :photos,       only: [:create, :destroy]
    resources :reviews,      only: [:create, :destroy]
    resources :payments,     only: [:new, :create]
    
    # put :favorite, on: :member
    # put :sold,     on: :member
    
    member do
      
      put :post
      put :favorite
      put :sold
      put :undo_sold
      put :bump
      
      get 'basics'
      get 'details'
      get 'photos'
      get 'about_you'
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
  
  resources :dealerships do
    
    resources :dealer_invitations
    resources :reviews, only: :destroy
    
    member do
      get 'authentication'
      get 'basics'
      get 'about'
      get 'contact'
      get 'hours'
      get 'address'
      get 'logo'
      get 'photo'
      get 'vehicles'
      get 'reviews'
    end
  end

  resources :conversations, only: [:index, :create] do
    
    resources :appointments, only:   [:new, :create, :destroy]
    resources :messages,     except: [:new, :edit, :show, :update]
    
    member do
      put :archive
    end
  end
  
  resources :discussions do
    
    resources :discussion_comments
    
    member do
      get :like,   to: "discussions#like"
      get :unlike, to: "discussions#unlike"
    end
    
    collection do
      get 'search'
      get :autocomplete
    end
  end
  
  resources :posts do
    
    resources :post_comments
    
    member do
      get :like,   to: "posts#like"
      get :unlike, to: "posts#unlike"
    end
  end
  
  resources :autoparts do
    member do
      put :favorite
      put :sold
      put :undo_sold
      put :bump
    end
  end
  
  resources :purchases do
    member do
      
      put :submit
      
      get 'order_received'
      get 'basics'
      get 'details'
      get 'billing'
      get 'employment'
      get 'financial'
    end
  end
  
  # match "conversations/:id/messages/accept" => "conversations#messages#accept", :as => "conversation_messages_accept_path"
  
  # match "conversations/:id/messages/decline" => "conversations#messages#decline", :as => "conversation_messages_decline_path"
end