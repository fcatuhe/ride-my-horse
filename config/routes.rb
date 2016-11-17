Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  mount Attachinary::Engine => "/attachinary"

  root to: 'pages#home'

  resources :users, only: [:show, :edit, :update]

  resources :horses

  resources :bookings

  resources :availabilities, only: [:new, :create]

end
