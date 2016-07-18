# dashboard and search should not be in static_pages
Rails.application.routes.draw do
  root                           'static_pages#home'
  get    'help'               => 'static_pages#help'
  get    'about'              => 'static_pages#about'
  get    'contact'            => 'static_pages#contact'
  get    'search'             => 'static_pages#search'
  get    'dashboard'          => 'static_pages#dashboard'
  get    'profile'            => 'static_pages#profile'
  get    'customers'          => 'appointments#customers'
  get    'test_drives'        => 'appointments#test_drives'
  get    'signup'             => 'users#new'
  get    'login'              => 'sessions#new'
  post   'login'              => 'sessions#create'
  delete 'logout'             => 'sessions#destroy'
  
  resources :users
  resources :vehicles
  resources :photos
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

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