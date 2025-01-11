class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @comments = Comment.includes(:user).all  # すべてのコメントを取得
  end
end
