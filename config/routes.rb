Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about" => "homes#about"

  devise_for :users
  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
  get "users/unsubscribe" => "users#unsubscribe"
  patch "users/withdraw"

  # devise_scope :user do
  #   post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  # end
end
