Rails.application.routes.draw do
  root to: 'home#index'
  resources :stores
  devise_for :users, :controllers => { registrations: 'registrations' }
end
