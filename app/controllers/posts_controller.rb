class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @posts = current_user.posts
    # @posts = Post.all
  end

  def show
    @post = Post.find(params[:id]) 
  end

  def create
     # １．current_userの投稿としてインスタンスを作成
     @post = current_user.posts.build(post_params)

     # ２．投稿が正常に保存できた場合
     if @post.save
       redirect_to root_path, notice: 'Post was successfully created.'
     else
       render :new
     end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
