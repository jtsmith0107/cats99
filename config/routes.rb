Rails.application.routes.draw do
  resources :cats do
    member do
      resources :cat_rental_requests
    end
  end

end
