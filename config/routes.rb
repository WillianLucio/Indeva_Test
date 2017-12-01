Rails.application.routes.draw do
  get 'sellers/show'

  get 'sellers/new'

  get 'sellers/edit'

  get 'sellers/index'

  get 'sellers/create'

  get 'sellers/update'

  get 'sellers/destroy'

  get 'sellers/raffle'

  root to: 'home#index'
  resources :stores
  devise_for :users, :controllers => { registrations: 'registrations' }
end
