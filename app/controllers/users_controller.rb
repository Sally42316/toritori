class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    # @user = current_user  # ログインしているユーザーを取得
  end

  def edit
    @user = current_user  # ログインしているユーザーを取得
  end

  def index
    @users = User.all
  end

  def update
    @user = current_user  # ログインしているユーザーを取得
    if @user.update(user_params)  # ユーザー情報を更新
      redirect_to @user, notice: 'Profile updated successfully'
    else
      # 更新に失敗した場合、エラーメッセージを表示
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :edit  # 編集フォームを再表示
    end
  end

  def destroy
    @user = current_user
    @user.destroy  # ユーザーを物理的に削除
    redirect_to new_user_registration_path, notice: 'Your account has been deleted'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    unless current_user == @user
      redirect_to root_path, alert: 'You are not authorized to edit this profile.'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email)  # 編集可能な属性を指定
  end
end
