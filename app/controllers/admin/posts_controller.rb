class Admin::PostsController < Admin::ApplicationController
  layout "application"
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments # 投稿に関連するコメントを取得
  end
  def destroy
    if @post
      @post.destroy
      redirect_to admin_posts_path, notice: '投稿が削除されました。'
    else
      redirect_to admin_comments_path, alert: '指定された投稿は存在しません。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
