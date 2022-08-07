Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about" => "homes#about"
  get "users/unsubscribe" => "users#unsubscribe"
  patch "users/withdraw" => "users#withdraw"

  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resource :favorites, only: [:create, :destroy]

  resources :users, only: [:index, :show, :edit, :update]

end
