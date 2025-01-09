class GroupUser < ApplicationRecord
    belongs_to :user
    belongs_to :group

    enum order_status: {
        applying: 0,
        approved: 1,
        }
end
