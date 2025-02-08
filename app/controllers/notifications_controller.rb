class NotificationsController < ApplicationController
    before_action :authenticate_user!  # ユーザーがログインしていることを確認

  # 未読通知の一覧を表示
  def index
    @notifications = current_user.notifications.unread.order(created_at: :desc)
  end




  # 通知の詳細を表示し、既読に更新
  def show
    @notification = Notification.find(params[:id])

    if @notification.nil?
      redirect_to notifications_path, alert: '通知が見つかりません。'
      return
    end
    
    # 既読に更新
    @notification.update(status: :read)

    # 通知タイプに応じて遷移先を設定
  case @notification.notification_type
  when 'like'
    redirect_to post_path(@notification.notifiable)
  when 'comment'
    redirect_to post_path(@notification.notifiable.post)  # 投稿に関連する場合はこのまま
  when 'group_apply'
    redirect_to group_path(@notification.notifiable)  # グループ詳細ページに遷移
  end
  end




  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to notifications_path, notice: '通知が既読されました。'
  end


end
