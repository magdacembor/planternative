Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :products do
    resources :reviews, only: [:show, :new, :create]
  end
  resources :shopping_lists, only: [:show, :update, :destroy]
  resources :reviews, only: :destroy
  get 'myprofile', to: 'pages#myprofile', as: :myprofile
end
