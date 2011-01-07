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
  match "signup", :to=>"users#new"
  match "login", :to=>"sessions#index", :as=>:login
  match "logout", :to=>"sessions#destroy", :as=>:logout

   root :to=>"account#login"

   match ':controller(/:action(/:id(.:format)))'
end
