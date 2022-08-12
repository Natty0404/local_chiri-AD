Rails.application.routes.draw do

  root to: "homes#top"
  get "home/about" => "homes#about"
  get "users/unsubscribe" => "users#unsubscribe"
  patch "users/withdraw" => "users#withdraw"
  get "users/favorite" => "users#favorite"

  devise_for :users

  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    get "favorite" => "users#favorite"
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
  end

   devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  # 管理者ログイン
  namespace :admin do
    get "/"=>"homes#top"
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update] do
      get "favorite" => "users#favorite"
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
  end

  # ゲストログイン
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end


end
