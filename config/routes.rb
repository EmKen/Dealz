Rails.application.routes.draw do
  root "listings#index"
  resources :users
  resources :listings
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#create_from_omniauth'
  get 'auth/failure', to: redirect('/')
end
