Rails.application.routes.draw do
  get 'searches/search'
  root to: "homes#top"
  get "home/about" => "homes#about"
  get "users/unsubscribe" => "users#unsubscribe"
  patch "users/withdraw" => "users#withdraw"
  get "users/favorite" => "users#favorite"
  get "search" => "searches#search"

  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  namespace'api' do
    namespace 'v1' do
      resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
        resources :post_comments, only: [:create, :destroy]
        resource :favorites, only: [:create, :destroy]
      end
    end
  end

  resources :users, only: [:index, :show, :edit, :update] do
    get "favorite" => "users#favorite"
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
  end

  # 管理者ログイン
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "/"=>"homes#top"
    get "search" => "searches#search"
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

end
