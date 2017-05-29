Rails.application.routes.draw do
  root "listings#index"
  resources :users
  get  '/signup',  to: 'users#new'
end
