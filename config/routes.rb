Rails.application.routes.draw do
  # get 'home/index'
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  unauthenticated do
    root "home#index"
  end

  authenticated :user do
    root 'secret#index', as: :authenticated_root
  end
end
