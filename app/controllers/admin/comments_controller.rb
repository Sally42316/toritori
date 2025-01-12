class Admin::CommentsController < Admin::ApplicationController
  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
  end
end
