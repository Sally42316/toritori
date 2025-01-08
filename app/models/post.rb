class Post < ApplicationRecord
    belongs_to :user
    has_many_attached :images # 複数画像の添付を許可
    has_many :comments, dependent: :destroy

    validates :text, presence: true

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
