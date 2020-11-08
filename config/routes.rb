Rails.application.routes.draw do
  resources :races
  # get 'home/index'
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  
  unauthenticated do
    root "home#index"
  end

  authenticated :user do
    root 'home#secret', as: :authenticated_root
  end
end
