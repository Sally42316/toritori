class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @comments = Comment.includes(:user, :post)
                       .order(created_at: :desc)
                       .page(params[:page])  # ページネーションを追加
                       .per(3)  # 1ページあたり3件を表示
  end
end
