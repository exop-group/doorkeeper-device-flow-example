Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users
  use_doorkeeper
  use_doorkeeper_device_authorization_grant

  root to: 'home#index'
  get 'me', to: 'api#me'
end
