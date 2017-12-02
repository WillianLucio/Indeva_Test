Rails.application.routes.draw do
  root to: 'home#index'
  resources :stores
  resources :sellers, except: [:index, :new]
  get 'store/sellers/:store_id' => 'sellers#index'
  get '/sellers/new/:store_id' => 'sellers#new'
  devise_for :users, :controllers => { registrations: 'registrations' }
end
