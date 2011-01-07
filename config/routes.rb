Vce::Application.routes.draw do
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
  match "login", :to=>"account#login"
  match "logout", :to=>"account#logout"


   root :to=>"account#login"

   match ':controller(/:action(/:id(.:format)))'
end
