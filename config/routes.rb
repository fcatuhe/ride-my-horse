Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  mount Attachinary::Engine => "/attachinary"

  root to: 'pages#home'

  resources :horses do
    resources :bookings, shallow: true
  end

  resources :users, only: [:show] do
  end

end
