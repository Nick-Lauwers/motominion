# dashboard, profile, and search should not be in static_pages
# create and destroy for enquiries

Rails.application.routes.draw do
  root                           'static_pages#home'
  get    'help'               => 'static_pages#help'
  get    'about'              => 'static_pages#about'
  get    'contact'            => 'static_pages#contact'
  get    'how-it-works'       => 'static_pages#how_it_works'
  get    'legal'              => 'static_pages#legal'
  get    'search'             => 'static_pages#search'
  get    'dashboard'          => 'static_pages#dashboard'
  get    'customers'          => 'appointments#customers'
  get    'test-drives'        => 'appointments#test_drives'
  get    'signup'             => 'users#new'
  get    'profile'            => 'users#profile'
  get    'login'              => 'sessions#new'
  post   'login'              => 'sessions#create'
  delete 'logout'             => 'sessions#destroy'
  
  resources :users
  resources :vehicles
  resources :photos
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :comments,            only: [:create, :destroy]
  resources :replies,             only: [:create, :destroy]
  resources :enquiries,           only: [:create]

  resources :vehicles do
    resources :appointments, only: [:create, :destroy]
  end
  
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end
  
  resources :vehicles do
    resources :reviews, only: [:create, :destroy]
  end
  
end