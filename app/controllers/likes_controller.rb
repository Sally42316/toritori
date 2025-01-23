class LikesController < ApplicationController
  before_action :set_post

   # いいねを作成
  def create
    unless @post.liked_by?(current_user)
      @post.likes.create(user: current_user)
    end
    redirect_to root_path, notice: 'いいねしました！'
  end

  # いいねを削除
  def destroy
    like = @post.likes.find_by(user: current_user)
    like.destroy if like
    redirect_to root_path, notice: 'いいねを解除しました！'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
