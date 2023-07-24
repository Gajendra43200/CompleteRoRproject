Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post 'login', to: 'authentication#login'
  resources :reviews
  resources :services
  resource :users
  get 'city', to: 'reviews#city'
  get 'search', to: 'reviews#location_service_name'
end
