Rails.application.routes.draw do
  get 'stores/show'

  get 'stores/index'

  get 'stores/create'

  get 'stores/update'

  get 'stores/destroy'

  devise_for :users, :controllers => { registrations: 'registrations' }
end
