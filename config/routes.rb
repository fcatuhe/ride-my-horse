Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  mount Attachinary::Engine => "/attachinary"

  root to: 'pages#home'

  resources :users, only: [:show]

  resources :horses

  resources :bookings

end
