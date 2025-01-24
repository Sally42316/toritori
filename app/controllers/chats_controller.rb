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

    # もしメッセージに住所が含まれていれば、Geocoding APIで緯度経度を取得
    if @chat.chat.include?('住所:')
      address = @chat.chat.split('住所:').last.strip
      geocode_result = Geocoder.search(address).first

      if geocode_result
        @chat.latitude = geocode_result.latitude
        @chat.longitude = geocode_result.longitude
      end
    end

    # チャットメッセージを保存
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
    # メッセージのみを許可しているため、位置情報（latitude, longitude）も許可する必要があります
    params.require(:chat).permit(:chat, :latitude, :longitude)
  end
end
