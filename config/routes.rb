Rails.application.routes.draw do

  get 'likes/create'
  get 'likes/destroy'
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
    # 画像削除用のアクションを追加
    member do
      delete :remove_image
    end
    resources :comments, only: [:create, :destroy]

    # いいね機能用のルーティング追加
    resources :likes, only: [:create, :destroy]
  end
  post 'posts' => 'posts#create'

  get "search" => "searches#search"

  resources :groups do
    resources :group_users, only: [:create, :destroy] do
      member do
        patch :approve  # 承認アクション
        delete :reject  # 拒否アクション（強制脱退）を追加
      end
    end
    # チャットリソースのルート追加
    resources :chats, only: [:index, :create, :destroy]
    # 追加: 自分のグループ一覧を表示するルート
    get 'my_groups', on: :collection
  end

  namespace :admin do
    get 'comments', to: 'homes#top'
    
    resources :comments, only: [:index, :show, :destroy]  
    resources :posts, only: [:show, :destroy]
    resources :users, only: [:show, :index, :edit, :destroy]
    resources :groups, only: [:index, :destroy] do
      resources :chats, only: [:index, :create, :destroy]
    end
  end
end
