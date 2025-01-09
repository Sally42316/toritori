Rails.application.routes.draw do
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


end
