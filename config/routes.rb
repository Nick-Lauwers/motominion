Rails.application.routes.draw do

  root                                'static_pages#home'
  get    'help'                    => 'static_pages#help'
  get    'about'                   => 'static_pages#about'
  get    'how-it-works'            => 'static_pages#how_it_works'
  get    'legal'                   => 'static_pages#legal'
  get    'customers'               => 'appointments#customers'
  get    'test-drives'             => 'appointments#test_drives'
  get    'signup'                  => 'users#new'
  get    'login'                   => 'sessions#new'
  get    'auth/:provider/callback' => 'sessions#create_social'
  post   'login'                   => 'sessions#create'
  delete 'logout'                  => 'sessions#destroy'
  
  resources :users
  resources :photos
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :comments,            only: [:create, :destroy]
  resources :replies,             only: [:create, :destroy]
  resources :enquiries,           only: [:new, :create]
  resources :profiles,            only: [:show, :edit, :update]

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end
  
  resources :posts do
    resources :responses
  end

  resources :vehicles do
    
    resources :appointments, only: [:create, :destroy]
    resources :reviews,      only: [:create, :destroy]
    
    collection do
      get 'search'
    end
  end
end