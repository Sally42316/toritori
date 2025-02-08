class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true  # 通知を受け取るユーザー
      t.references :sender, null: false, foreign_key: { to_table: :users }  # 通知を送るユーザー（いいねをしたユーザー）
      t.references :notifiable, polymorphic: true, null: false  # 通知対象（投稿やコメント）
      t.integer :notification_type, null: false, default: 0  # 通知の種類（例: いいね）
      t.integer :status, null: false, default: 0  # 通知の状態（未読 or 既読）

      t.timestamps
    end
  end
end
