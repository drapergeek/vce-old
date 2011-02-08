Vce::Application.routes.draw do
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
  resources  :session
  resources :receipts
  resources :campers
  resources :buses
  match "signup", :to=>"users#new"
  match "login", :to=>"sessions#index", :as=>:login
  match "logout", :to=>"sessions#destroy", :as=>:logout

   root :to=>"sessions#index"

   match ':controller(/:action(/:id(.:format)))'
end
