class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def index
    # グループ内の全てのチャットを取得
    @chats = @group.chats.includes(:user).order(created_at: :asc)
    @chat = Chat.new
  end

  def create
    if chat_params[:address].present? && chat_params[:postal_code].present?
      chat = "#{chat_params[:chat]}" + "#{chat_params[:postal_code]}" + "#{chat_params[:address]}"
      @chat = @group.chats.new(chat: chat)
    else
      @chat = @group.chats.new(chat: chat_params[:chat])
    end
    @chat.user = current_user

    if @chat.save
      redirect_to group_chats_path(@group)
    else
      @chats = @group.chats.includes(:user).order(created_at: :asc)
      render :index
    end
  end

  def destroy
    chat = @group.chats.find(params[:id])
    if current_user == chat.user || @group.is_owned_by?(current_user)
      chat.destroy
      redirect_to group_chats_path(@group), notice: 'チャットを削除しました。'
    else
      redirect_to group_chats_path(@group), alert: '削除する権限がありません。'
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
    # ユーザーがグループのメンバー、またはオーナーであるか確認
    unless @group.users.include?(current_user) || @group.is_owned_by?(current_user)
      redirect_to groups_path, alert: 'あなたはグループメンバーではありません'
    end
  end

  def chat_params
    # `address`を許可する
    params.require(:chat).permit(:chat, :address, :postal_code)
  end
end
