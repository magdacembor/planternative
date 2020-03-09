Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home', as: :home
  resources :products do
    resources :reviews, only: :create
    resources :quantities, only: :create
  end
  resources :quantities, only: [ :update, :destroy ]
  resources :shopping_lists, only: [:show, :update, :destroy, :create]
  resources :reviews, only: :destroy
  resources :chatrooms, only: [ :index, :show, :new, :create ] do
    resources :messages, only: :create
  end
  get '/:nickname', to: 'pages#myprofile', as: :myprofile
end
