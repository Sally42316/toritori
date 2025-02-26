class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :notifications, dependent: :destroy

  # プロフィール画像を扱うためにActiveStorageを設定
  has_one_attached :avatar  # 画像アップロードの関連付け

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, on: :create

  # 検索メソッド
  def self.looks(search, word)
    case search
    when "perfect_match"
      # 完全一致
      User.where("name = ?", word)
    when "forward_match"
      # 前方一致
      User.where("name LIKE ?", "#{word}%")
    when "backward_match"
      # 後方一致
      User.where("name LIKE ?", "%#{word}")
    when "partial_match"
      # 部分一致
      User.where("name LIKE ?", "%#{word}%")
    else
      # 他の場合は全件取得
      User.all
    end
  end

  # ユーザーが削除されている場合はログインできないようにする
  def active_for_authentication?
    super && !is_deleted  # is_deletedがtrueならログインできない
  end

  # 削除されたユーザーには特別なメッセージを表示
  def inactive_message
    is_deleted ? :deleted : super
  end



  
end
