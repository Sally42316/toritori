class GroupUser < ApplicationRecord
    belongs_to :user
    belongs_to :group

    enum status: {
        applying: 0, # 申請中
        approved: 1, # 承認済み
      }
end
