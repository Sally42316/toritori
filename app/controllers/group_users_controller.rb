class GroupUsersController < ApplicationController
    before_action :authenticate_user!
  
  # 参加申請
  def create
    group_user = current_user.group_users.new(group_id: params[:group_id], status: :applying)
    if group_user.save
      flash[:notice] = '参加申請を送信しました。'
    else
      flash[:alert] = '参加申請の送信に失敗しました。'
    end
    redirect_to request.referer
  end

  # グループから退出
  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])

    # 現在のユーザーがそのグループに所属していない場合の処理
    if group_user.nil?
      flash[:alert] = 'グループから退出できません。参加していないグループです。'
      redirect_to request.referer and return
    end

    if group_user.destroy
      flash[:notice] = 'グループから退出しました。'
    else
      flash[:alert] = 'グループから退出できませんでした。'
    end
    redirect_to request.referer
  end

  # 承認処理
  def approve
    group_user = GroupUser.find_by(id: params[:id], group_id: params[:group_id])
    if group_user&.update(status: :approved)
      flash[:notice] = '参加申請を承認しました。'
    else
      flash[:alert] = '承認に失敗しました。'
    end
    redirect_to request.referer
  end
end
