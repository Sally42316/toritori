class Admin::CommentsController < Admin::ApplicationController
  layout "application"
  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path, notice: 'コメントが削除されました。'
  end

  def index
    # コメントと関連する投稿を取得
    @comments = Comment.includes(:post, :user).all
  end

end
