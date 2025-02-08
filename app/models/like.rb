class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

   # いいねを作成する際に通知を送信
   after_create :create_like_notification

   private
 
   # いいね通知を作成
   def create_like_notification
     Notification.create(
       user_id: post.user.id,   # 通知を受け取るユーザー（投稿主）
       sender_id: user.id,      # 通知を送ったユーザー（いいねをしたユーザー）
       notifiable: post,        # 通知対象（投稿）
       notification_type: :like # 通知の種類
     )
   end
end
