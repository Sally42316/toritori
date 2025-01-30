class HomesController < ApplicationController
  def top
  #   # ログインユーザーの投稿と他ユーザーの投稿を時系列順に取得
  #   # @posts = Post.order(created_at: :desc).includes(:user) # 投稿を新しい順に取得
  #   # 「いいね数順」に並べ替えを実現
  #   if params[:sort] == 'likes'
  #     # いいね数順に並べ替え（left_joinsを使っていいね数0の投稿も含める）
  #     @posts = Post.left_joins(:likes).group(:id).order('COUNT(likes.id) DESC')
  #   else
  #     # デフォルトは投稿日時順
  #     @posts = Post.order(created_at: :desc)
  #   end
  # end

  # def about
  # end
  if params[:sort] == 'likes'
    @posts = Post.left_joins(:likes)
                 .joins(:user)  # ユーザーと関連付けて
                 .where(users: { is_deleted: false })  # ユーザーが削除されていない投稿のみ
                 .group(:id)
                 .order('COUNT(likes.id) DESC')
  else
    @posts = Post.joins(:user)
                 .where(users: { is_deleted: false })  # ユーザーが削除されていない投稿のみ
                 .order(created_at: :desc)
  end
end
end
