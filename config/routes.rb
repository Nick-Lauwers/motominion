# dashboard, profile, and search should not be in static_pages
# create and destroy for enquiries

Rails.application.routes.draw do
  get 'profiles/show'

  get 'profiles/show'

  root                           'static_pages#home'
  get    'help'               => 'static_pages#help'
  get    'about'              => 'static_pages#about'
  get    'contact'            => 'static_pages#contact'
  get    'how-it-works'       => 'static_pages#how_it_works'
  get    'legal'              => 'static_pages#legal'
  get    'customers'          => 'appointments#customers'
  get    'test-drives'        => 'appointments#test_drives'
  get    'signup'             => 'users#new'
  get    'login'              => 'sessions#new'
  post   'login'              => 'sessions#create'
  delete 'logout'             => 'sessions#destroy'
  
  resources :users
  resources :photos
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :comments,            only: [:create, :destroy]
  resources :replies,             only: [:create, :destroy]
  resources :enquiries,           only: [:create]
  resources :profiles,            only: [:show, :edit, :update]

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  resources :vehicles do
    
    collection do
      get 'search'
    end
    
    resources :appointments, only: [:create, :destroy]
    resources :reviews, only: [:create, :destroy]
  end
end