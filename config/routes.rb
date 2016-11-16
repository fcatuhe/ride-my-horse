Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  mount Attachinary::Engine => "/attachinary"

  root to: 'pages#home'

  resources :horses, only: [:index, :show] do
    resources :bookings, shallow: true
  end

  resources :users, only: [:show] do
    resources :horses
  end

end
