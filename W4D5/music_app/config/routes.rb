Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:create, :new, :show]
  resources :bands, only: [:create, :new, :edit, :show, :update, :destroy]
  
end
