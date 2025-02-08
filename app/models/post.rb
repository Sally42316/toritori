class Post < ApplicationRecord
    belongs_to :user
    has_many_attached :images # 複数画像の添付を許可
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy

    validates :text, presence: { message: :blank }

    # いいねされているかチェック
  def liked_by?(user)
    likes.exists?(user: user)
  end

 # 投稿にいいねがついた時に通知を作成
 def create_like_notification(liker)
  # 同じユーザーから同じ投稿に対する通知がすでに存在するかを確認
  existing_notification = Notification.find_by(
    user: self.user,          # 通知を受け取るユーザー（投稿のオーナー）
    sender: liker,            # 通知を送るユーザー（いいねをしたユーザー）
    notifiable: self,         # 通知対象（この投稿）
    notification_type: 'like' # 通知の種類
  )

  # もし通知がまだ存在しない場合のみ新しい通知を作成
  unless existing_notification
    Notification.create(
      user: self.user,        # 通知を受け取るユーザー（投稿のオーナー）
      sender: liker,          # 通知を送るユーザー（いいねをしたユーザー）
      notifiable: self,       # 通知対象（この投稿）
      notification_type: 'like' # 通知の種類
    )
  end
end

    # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("text LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("text LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("text LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("text LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
end
