class Chat < ApplicationRecord
    belongs_to :group
    belongs_to :user

    # Geocodingを有効化
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  
    validates :chat, presence: true
end
