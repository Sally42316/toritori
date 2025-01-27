Rails.application.routes.draw do

  # いいね機能
  get 'likes/create'
  get 'likes/destroy'

  # 管理者用認証
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/sessions',
    registrations: 'admin/registrations',
    passwords: 'admin/passwords'
  }

  # ユーザー用認証
  devise_for :users

  # ルート
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: 'about'

  # ユーザーリソース
  resources :users, only: [:show, :edit, :update, :destroy, :index]

  # 投稿リソース
  resources :posts, only: [:new, :show, :edit, :update, :destroy, :index] do
    # 画像削除用のアクション
    member do
      delete :remove_image
    end

    # コメントリソース
    resources :comments, only: [:create, :destroy]

    # いいね機能
    resources :likes, only: [:create, :destroy]
  end
  post 'posts', to: 'posts#create'

  # 検索機能
  get 'search', to: 'searches#search'

  # グループ関連
  resources :groups do
    # グループメンバー管理
    resources :group_users, only: [:create, :destroy] do
      member do
        patch :approve  # 承認アクション
        delete :reject  # 拒否アクション（強制脱退）
      end
    end

    # チャット機能
    resources :chats, only: [:index, :create, :destroy]

    # 自分のグループ一覧
    get 'my_groups', on: :collection
  end

  # 管理者用ネームスペース
  namespace :admin do
    get 'comments', to: 'homes#top'

    # コメント関連
    resources :comments, only: [:index, :show, :destroy]

    # 投稿関連
    resources :posts, only: [:show, :destroy]

    # ユーザー関連
    resources :users, only: [:show, :index, :edit, :destroy]

    # グループ関連
    resources :groups, only: [:index, :destroy] do
      resources :chats, only: [:index, :create, :destroy]
    end
  end
end
