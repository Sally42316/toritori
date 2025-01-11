class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @comments = Comment.all
    redirect_to admin_comments_path
  end
end
