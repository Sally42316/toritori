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
      flash[:alert] = @post.errors.full_messages.to_sentence # エラーメッセージをフラッシュに設定
       render :new
     end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    
    # 投稿を更新
    if @post.update(post_params)
      # 更新成功時は投稿詳細ページにリダイレクト
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      # 更新失敗時は編集ページを再表示
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully deleted.'
  end

  private
  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :text, images: []) # images: []で複数の画像を受け取る
  end
end
