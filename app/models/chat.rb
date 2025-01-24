class Chat < ApplicationRecord
    belongs_to :group
    belongs_to :user
  
    # メッセージが存在することを検証
  validates :chat, presence: true

  # addressが変更されたときに緯度経度を計算
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # addressが必須項目であることを検証
  validates :address, presence: true, allow_blank: true
end
