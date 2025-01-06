class HomesController < ApplicationController
  def top
    # ログインユーザーの投稿と他ユーザーの投稿を時系列順に取得
    @posts = Post.order(created_at: :desc).includes(:user) # 投稿を新しい順に取得
  end

  def about
  end
end
