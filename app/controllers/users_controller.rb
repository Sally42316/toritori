class UsersController < ApplicationController
  def show
    @user = current_user  # ログインしているユーザーを取得
  end

  def edit
    @user = current_user  # ログインしているユーザーを取得
  end

  def update
    @user = current_user  # ログインしているユーザーを取得
    if @user.update(user_params)  # ユーザー情報を更新
      redirect_to @user, notice: 'Profile updated successfully'
    else
      render :edit  # 更新に失敗した場合は再度編集フォームを表示
    end
  end

  def destroy
    @user = current_user
    @user.destroy  # ユーザーを物理的に削除
    redirect_to new_user_registration_path, notice: 'Your account has been deleted'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :bio)  # 編集可能な属性を指定
  end
end
