class AddGroupApplyNotificationTypeToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :notification_type, :integer, default: 0, null: false
  end
end
