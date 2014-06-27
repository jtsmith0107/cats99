Rails.application.routes.draw do
  resources :users, only: [:create, :new, :index, :update, :show]

  get "logout", to: "sessions#destroy" 
  resource :session
  
  resources :cats do
    member do
      resources :cat_rental_requests
    end
  end

end
