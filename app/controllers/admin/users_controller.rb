class Admin::UsersController < Admin::ApplicationController
  layout "application"
  def show
    @user = User.find(params[:id])
    @posts = @user.posts # ユーザーの全投稿を取得
    @comments = @user.comments # ユーザーの全コメントを取得
  end

  def index
    @users = User.order(created_at: :desc)  # 最新登録順（降順）で並び替え
                  .page(params[:page])
                  .per(3)  # 1ページあたり3件を表示

    Rails.logger.info "Users: #{@users.inspect}"
  end

  def edit
  end

  def destroy
    @user = User.find(params[:id])

    # MySQLかSQLiteかで外部キー制約を無効にする方法を変更
    if ActiveRecord::Base.connection.adapter_name == 'Mysql2'
      # MySQLの場合
      ActiveRecord::Base.connection.execute("SET foreign_key_checks = 0;")
    elsif ActiveRecord::Base.connection.adapter_name == 'SQLite'
      # SQLiteの場合
      ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = OFF;")
    end

    # まず関連するレコードを削除
    @user.posts.destroy_all
    @user.comments.destroy_all

    # ユーザーを物理削除
    @user.destroy

   # 外部キー制約を再度有効にする
   if ActiveRecord::Base.connection.adapter_name == 'Mysql2'
    # MySQLの場合
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 1;")
  elsif ActiveRecord::Base.connection.adapter_name == 'SQLite'
    # SQLiteの場合
    ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = ON;")
  end

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
