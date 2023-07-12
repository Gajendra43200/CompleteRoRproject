Rails.application.routes.draw do
  post 'login', to: 'authentication#login'

  post 'admins', to: 'admins#create'

  get 'index', to: 'admins#index'

  post 'customers', to: "customers#create"

  get  'allcustomer', to: 'services#show_all_customer'

  resources :services

  get 'servicewith', to: 'services#services_with_names'

  post'reviewcreate',to: 'reviews#create'

  get 'singleservice', to: 'customers#search_service'

  get 'city', to: 'customers#city'

  # get 'sortbyratings', to: 'customers#sort_by_ratings'

  get 'sortbyratings', to: 'customers#sort_filter_by_rating'


  get 'filterbyratings', to: 'customers#filter_by_ratings'

  get 'filterbystatus', to: 'customers#filter_by_status'

  get 'serviceslocationwise', to: 'customers#search_by_location_services'

end
