class Admin::UsersController < Admin::ApplicationController
  layout "application"
  def show
    @user = User.find(params[:id])
    @posts = @user.posts # ユーザーの全投稿を取得
    @comments = @user.comments # ユーザーの全コメントを取得
  end

  def index
    @users = User.all
  end

  def edit
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_comments_path, notice: 'ユーザーが削除されました。'
  end
end
