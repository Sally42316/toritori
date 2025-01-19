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
    resources :comments, only: [:create, :destroy]
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
  end

  namespace :admin do
    get 'comments', to: 'homes#top'
    
    resources :comments, only: [:index, :show, :destroy]  
    resources :posts, only: [:show, :destroy]
    resources :users, only: [:show, :index, :edit, :destroy]
  end
end
