Vce::Application.routes.draw do
  resources :schools
  resources :packs

  match '/auth/:provider/callback' => 'sessions#create'
  resources :possible_issues do 
    collection do 
      get 'check'
    end
  end
  resources :issues
  resources :annoucements
  resources :roles
  resources :rights
  resources :units
  resources :users
  resources  :sessions
  resources :receipts do
    collection do
      get 'totals'
    end
  end
  resources :campers do
    collection do
      post 'add_course'
      get 'remove_course'
      get 'existing_camper'
    end
    member do
      get 'find_by_number'
    end
  end
  resources :buses do
    collection do
      get 'remove_camper'
    end
  end
  match "signup", :to=>"users#new"
  match "login", :to=>"sessions#new", :as=>:login
  match "logout", :to=>"sessions#destroy", :as=>:logout
  root :to=>"receipts#index"

   match ':controller(/:action(/:id(.:format)))'
end
