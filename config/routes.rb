Rails.application.routes.draw do
  root                       'static_pages#home'
  get    'help'             => 'static_pages#help'
  get    'about'            => 'static_pages#about'
  get    'contact'          => 'static_pages#contact'
  get    'search_results'   => 'static_pages#search_results'
  get    'vehicle_details'  => 'static_pages#vehicle_details'
  get    'signup'           => 'users#new'
  get    'login'            => 'sessions#new'
  post   'login'            => 'sessions#create'
  delete 'logout'           => 'sessions#destroy'
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :vehicles
  resources :photos
  resources :vehicles do
    resources :appointments, only: [:create]
  end
  get '/shopping_cart' => 'appointments#shopping_cart'
  get '/your_appointments' => 'appointments#your_appointments'
end