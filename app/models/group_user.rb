class GroupUser < ApplicationRecord
    belongs_to :user
    belongs_to :group

    enum status: {
        applying: 0, # 申請中
        approved: 1, # 承認済み
      }

    # 承認待ちの参加申請があった場合にオーナーに通知を送信
  after_create :notify_group_owner_if_applying

  private

  def notify_group_owner_if_applying
    # 参加申請が「申請中」の場合
    if applying?
      Notification.create(
        user: group.owner,  # 通知の受け手はグループのオーナー
        sender: user,  # 申請者
        notifiable: group,  # 通知対象はグループ
        notification_type: 'group_apply'  # 新しい通知タイプ「group_apply」を追加
      )
    end
  end
end
