class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :remove_image]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    if params[:sort] == 'likes'
      # いいね数順に並べ替え（left_joinsを使うことでいいね数0の投稿も含める）
      @posts = Post.left_joins(:likes).group(:id).order('COUNT(likes.id) DESC')
    else
      # デフォルトは投稿日時順
      @posts = Post.all.order(created_at: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path, notice: '投稿しました'
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    # 既存の画像を保持し、新しい画像を追加
    if params[:post][:images].present?
      # 新しくアップロードされた画像を追加する
      @post.images.attach(params[:post][:images])
    end

    # 投稿内容を更新
    if @post.update(post_params)
      redirect_to @post, notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '削除完了'
  end

  def remove_image
    @post.images.find(params[:image_id]).purge
    redirect_to edit_post_path(@post), notice: '画像を削除しました'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user
    unless @post.user == current_user
      redirect_to posts_path, alert: '編集権限がありません'
    end
  end

  def post_params
    params.require(:post).permit(:title, :text, images: [])
  end
end
