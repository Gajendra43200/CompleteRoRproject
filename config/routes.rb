Rails.application.routes.draw do
  post 'login', to: 'authentication#login'

  post 'admins', to: 'admins#create'

  get 'index', to: 'services#index'

  get  'allcustomer', to: 'services#show_all_customer'

  resources :services

  get 'servicewith', to: 'services#services_with_names'

  post'reviewcreate',to: 'reviews#create'

  get 'allservice', to: 'services#all_services'

  get 'city', to: 'customers#city'
  
  get 'singleservice', to: 'customers#search_service'
  
  get 'allservices', to: 'customers#all_services'
  
  post 'customers', to: "customers#create"
  
  get 'serviceslocationwise', to: 'customers#search_by_location_services'
  
  get 'servicefiltersortstatus', to: 'customers#sort_filter_by_rating'
  

end
