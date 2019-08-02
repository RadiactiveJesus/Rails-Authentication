Rails.application.routes.draw do
  get 'sessions/new' 
  get 'sessions/create'
  get 'sessions/destroy'
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  root   'home#index'  
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'signup', to: 'users#new', as: 'signup'
end
