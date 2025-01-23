class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post

    if @comment.save
      # コメントが保存された場合、非同期通信で新しいコメントを返す
      respond_to do |format|
        format.js  # コメントが投稿されたことを反映させるJSファイルを呼び出す
      end
    else
      # エラーが発生した場合
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    respond_to do |format|
      format.js  # コメント削除後にページを更新するJSファイルを呼び出す
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end