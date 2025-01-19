class ChatsController < ApplicationController
    before_action :authenticate_user!
  before_action :set_group

  def index
    # グループ内の全てのチャットを取得
    @chats = @group.chats.includes(:user).order(created_at: :asc)
    @chat = Chat.new
  end

  def create
    @chat = @group.chats.build(chat_params)
    @chat.user = current_user

    if @chat.save
      redirect_to group_chats_path(@group)
    else
      @chats = @group.chats.includes(:user).order(created_at: :asc)
      render :index
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
    # ユーザーがそのグループのメンバーか確認
    unless @group.users.include?(current_user)
      redirect_to groups_path, alert: 'You are not a member of this group.'
    end
  end

  def chat_params
    params.require(:chat).permit(:chat)
  end
end
