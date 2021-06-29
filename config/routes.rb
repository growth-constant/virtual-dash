require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :races do
    get :leaderboard, on: :member
    get :general_classification, on: :member
    get 'personal/(:user_id)', to: 'races#personal', as: 'personal', on: :member
    resources :registration, only: [:new] do
      post :checkout_session, on: :collection
      get :checkout_successful, on: :collection
      get :status, on: :member
    end
  end
  # get 'home/index'
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  resources :users, only: %i[edit update]
  get :activity, to: 'users#activity'

  get :about, to: 'home#about'

  unauthenticated do
    root 'home#index'
  end

  authenticated :user do
    root 'races#index', as: :authenticated_root
  end
end
