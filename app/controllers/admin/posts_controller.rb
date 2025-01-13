class Admin::PostsController < Admin::ApplicationController
  layout "application"
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments # 投稿に関連するコメントを取得
  end
end
