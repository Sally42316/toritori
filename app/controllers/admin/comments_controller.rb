class Admin::CommentsController < Admin::ApplicationController
  layout "application"
  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
  end
end
