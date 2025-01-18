class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_users, dependent: :destroy


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

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users

  
end
