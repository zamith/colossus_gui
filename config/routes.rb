Rails.application.routes.draw do
  root to: "pools#index"

  resources :pools, only: [:index]
  resources :tickets, only: [:index, :new, :create]
end
