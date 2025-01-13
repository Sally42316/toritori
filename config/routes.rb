Rails.application.routes.draw do

  devise_for :admins, path: 'admin', controllers: {
    sessions: "admin/sessions",
    registrations: "admin/registrations",
    passwords: "admin/passwords"
  }


  devise_for :users

  root to: 'homes#top'
  get 'homes/about', to: "homes#about", as: 'about'

  resources :users, only: [:show, :edit, :update, :destroy, :index]

  resources :posts, only: [:new, :show, :edit, :update, :destroy, :index] do
    # ここでpost_commentsなどをネストできます。
    resources :comments, only: [:create, :destroy]
  end
  post 'posts' => 'posts#create'

  get "search" => "searches#search"

  resources :groups, except: [:destroy]

  namespace :admin do
    # root to: 'homes#top'
    get 'comments', to: 'homes#top'
    
    resources :comments, only: [:index, :show, :destroy]  # コメント関連のリソース
    resources :posts, only: [:show, :destroy] # 投稿詳細
    resources :users, only: [:show, :index, :edit, :destroy] # 投稿詳細


  end
end
