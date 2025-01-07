Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get 'homes/about', to: "homes#about", as: 'about'

  resources :users, only: [:show, :edit, :update, :destroy, :index]

  resources :posts, only: [:new, :show, :edit, :update, :destroy, :index]
  post 'posts' => 'posts#create'

  # root to: 'posts#index' →current userの投稿一覧になるのでダメ

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
