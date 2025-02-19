class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @comments = Comment.includes(:user, :post).order(created_at: :desc)  # コメントを新着順に取得
  end
end
