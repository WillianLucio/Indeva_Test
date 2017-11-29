Rails.application.routes.draw do
  root to: 'home#index'
  resources :stores, only: [:index, :show, :create, :update, :destroy]
  devise_for :users, :controllers => { registrations: 'registrations' }
end
