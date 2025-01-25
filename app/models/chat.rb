class Chat < ApplicationRecord
    belongs_to :group
    belongs_to :user
    belongs_to :parent_chat, class_name: 'Chat', optional: true

  # メッセージが返信の場合、元のメッセージを関連付け
  has_many :replies, class_name: 'Chat', foreign_key: :parent_chat_id, dependent: :destroy
  
    validates :chat, presence: true
end
