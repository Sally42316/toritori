class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post

    after_create :create_notification

  private

  def create_notification
    # コメントされた投稿の著者に通知を送る
    post_author = post.user
    message = "#{user.name}さんがあなたの投稿にコメントしました。"

    # 通知を作成
    Notification.create!(
      user: post_author, # 通知を受け取るユーザー（投稿者）
      sender_id: user.id, # 通知を送るユーザー（コメント者）
      notifiable_type: "Comment", # 通知対象となるモデル（コメント）
      notifiable_id: self.id, # コメントのID
      notification_type: 1, # コメントに関する通知タイプ（例: コメント通知）
      status: 0 # 未読通知
    )
  end
end
