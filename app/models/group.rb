class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, source: :user
  belongs_to :owner, class_name: 'User' # オーナーはUserモデルに関連付け

  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :detail, presence: true

  # オーナー判定
  def is_owned_by?(user)
    owner_id == user.id
  end

  # グループ画像取得
  def get_image
    image.attached? ? image : 'no_image.jpg'
  end

  # 特定のユーザーがグループに含まれるか判定
  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end

  # 承認された参加者数を取得
  def approved_users_count
    group_users.where(status: :approved).count
  end
end
