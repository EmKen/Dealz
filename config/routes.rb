Rails.application.routes.draw do
  get 'braintree/new'

  root "listings#index"
  resources :users
  resources :listings
  resources :listings do
    resources :orders
  end
  resources :orders do
    resources :braintree, only: [:new]
  end
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#create_from_omniauth'
  get 'auth/failure', to: redirect('/')
  post 'braintree/checkout'
end
