class Notification < ApplicationRecord
  belongs_to :user  # 通知を受け取るユーザー
  belongs_to :sender, class_name: 'User'  # 通知を送るユーザー（例えば、いいねをしたユーザー）
  belongs_to :notifiable, polymorphic: true  # 通知対象（投稿、コメントなど）

  enum notification_type: { like: 0, comment: 1, group_apply: 2 }  # 通知の種類（例: いいねやコメント）
  enum status: { unread: 0, read: 1 }  # 通知の状態（未読 or 既読）

  # 通知メッセージの生成
  def message
    case notification_type
    when 'like'
      "#{sender.name} があなたの投稿にいいねしました"
    when 'comment'
      "#{sender.name} があなたの投稿にコメントしました"
    when 'group_apply'
      "#{sender.name} があなたのグループに参加申請しました"
    end
  end
end
