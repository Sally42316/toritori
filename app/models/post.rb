class Post < ApplicationRecord
    belongs_to :user
    has_many_attached :images # 複数画像の添付を許可

    validates :title, presence: true
    validates :text, presence: true
end
