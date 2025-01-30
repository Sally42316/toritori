class Admin::UsersController < Admin::ApplicationController
  layout "application"
  def show
    @user = User.find(params[:id])
    @posts = @user.posts # ユーザーの全投稿を取得
    @comments = @user.comments # ユーザーの全コメントを取得
  end

  def index
    @users = User.all
    Rails.logger.info "Users: #{@users.inspect}"
  end

  def edit
  end

  def destroy
    @user = User.find(params[:id])

    # 外部キー制約を無効にする
    ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = OFF;")

    # まず関連するレコードを削除
    @user.posts.destroy_all
    @user.comments.destroy_all

    # ユーザーを物理削除
    @user.destroy

    # 外部キー制約を再度有効にする
    ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = ON;")

    redirect_to admin_comments_path, notice: 'ユーザーが削除されました。'
  end

  # 会員復帰アクション
  def restore
    @user = User.find(params[:id])
    if @user.update(is_deleted: false)
      redirect_to admin_user_path(@user), notice: 'ユーザーが復帰しました。'
    else
      redirect_to admin_user_path(@user), alert: 'ユーザー復帰に失敗しました。'
    end
  end
end
