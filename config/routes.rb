Rails.application.routes.draw do

  get 'message_photos/create'

  root                                'static_pages#home'
  get    'help'                    => 'static_pages#help'
  get    'about'                   => 'static_pages#about'
  get    'how-it-works'            => 'static_pages#how_it_works'
  get    'dashboard'               => 'static_pages#dashboard'
  get    'tour'                    => 'static_pages#tour'
  get    'legal'                   => 'static_pages#legal'
  get    'feed_0'                  => 'vehicles#feed_0'
  get    'feed_1'                  => 'vehicles#feed_1'
  get    'feed_2'                  => 'vehicles#feed_2'
  get    'feed_3'                  => 'vehicles#feed_3'
  get    'feed_4'                  => 'vehicles#feed_4'
  get    'feed_5'                  => 'vehicles#feed_5'
  get    'feed_6'                  => 'vehicles#feed_6'
  get    'feed_7'                  => 'vehicles#feed_7'
  get    'feed_8'                  => 'vehicles#feed_8'
  get    'feed_9'                  => 'vehicles#feed_9'
  get    'feed_10'                 => 'vehicles#feed_10'
  get    'feed_11'                 => 'vehicles#feed_11'
  get    'feed_12'                 => 'vehicles#feed_12'
  get    'feed_13'                 => 'vehicles#feed_13'
  get    'feed_14'                 => 'vehicles#feed_14'
  get    'feed_15'                 => 'vehicles#feed_15'
  get    'feed_16'                 => 'vehicles#feed_16'
  get    'feed_17'                 => 'vehicles#feed_17'
  get    'feed_18'                 => 'vehicles#feed_18'
  get    'feed_19'                 => 'vehicles#feed_19'
  get    'feed_20'                 => 'vehicles#feed_20'
  get    'admin'                   => 'dealerships#admin'
  get    'customers'               => 'appointments#customers'
  get    'test-drives'             => 'appointments#test_drives'
  get    'purchases_made'          => 'purchases#purchases_made'
  get    'orders_received'         => 'purchases#orders_received'
  # get    'start_personalized_search' => 'personalized_searches#start'
  get    'payment_method'          => 'users#payment'
  get    'payout_method'           => 'users#payout'
  get    'signup'                  => 'users#new'
  get    'login'                   => 'sessions#new'
  get    'auth/:provider/callback' => 'sessions#create_social'
  post   'login'                   => 'sessions#create'
  post   'password'                => 'sessions#create'
  post   'upload'                  => 'vehicles#upload'
  post   'add_card'                => 'users#add_card'
  delete 'logout'                  => 'sessions#destroy'
  
  resources :autopart_photos
  resources :message_photos
  resources :blogs
  resources :account_activations,    only: [:edit]
  resources :dealership_activations, only: [:edit]
  resources :password_resets,        only: [:new, :create, :edit, :update]
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
    
    # resource :personalized_search do
    #   member do
    #     get 'price'
    #     get 'mileage'
    #     get 'year'
    #     get 'installed_options'
    #     get 'summary'
    #   end
    # end

    member do
      get 'password'
      get 'profile_pic'
      get 'profile_pic_dealer'
      get 'dealer_details'
      get 'shortlist'
    end
  end

  resources :vehicles do
    
    resources :reviews,  only: [:create, :destroy]
    resources :payments, only: [:new, :create]
    
    # put :favorite, on: :member
    # put :sold,     on: :member
    
    member do
      
      put :post
      put :favorite
      put :unfavorite
      put :sold
      put :undo_sold
      put :bump
      
      get 'basics'
      get 'details'
      get 'photos'
      get 'about_you'
      get 'consumer_activity'
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
    
    resources :photos, only: [:create, :destroy] do
      member do
        put :rotate
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
      get 'performance'
      get 'inventory'
    end
  end

  resources :conversations, only: [:index, :create] do
    
    resources :appointments, only:   [:new, :create, :destroy]
    resources :messages,     except: [:new, :edit, :show, :update]
    
    member do
      put :archive
      put :reveal_identity
      put :hide_identity
      get 'export'
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
      
      get 'order'
      get 'basics'
      get 'details'
      get 'billing'
      get 'employment'
      get 'financial'
    end
  end
  
  resources :personalized_searches do
    
    collection do
      get 'start'
      get 'survey'
    end
    
    member do
      
      put :all_manufacturers
      
      get 'style'
      get 'manufacturer'
      get 'price'
      get 'mileage'
      get 'location'
    end
  end
  
  # match "conversations/:id/messages/accept" => "conversations#messages#accept", :as => "conversation_messages_accept_path"
  
  # match "conversations/:id/messages/decline" => "conversations#messages#decline", :as => "conversation_messages_decline_path"
end