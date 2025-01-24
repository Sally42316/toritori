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

    # 住所がある場合、Geocoding APIで緯度経度を取得
    if @chat.address.present?
      geocode_result = Geocoder.search(@chat.address).first

      if geocode_result
        @chat.latitude = geocode_result.latitude
        @chat.longitude = geocode_result.longitude
      end
    end

    # チャットメッセージを保存
    if @chat.save
      # チャット作成後にチャット一覧を取得し、リダイレクト先で表示
      @chats = @group.chats.includes(:user).order(created_at: :asc)
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
    # メッセージ、住所（address）を許可
    params.require(:chat).permit(:chat, :latitude, :longitude, :address, :zipcode)
  end

  # 住所をジオコーディングして緯度経度を取得するメソッド
  def geocode_address(address)
    api_key = ENV['Geocoding_API_Key']
    base_url = "https://maps.googleapis.com/maps/api/geocode/json"
  
  # 住所を適切にエンコード
  encoded_address = URI.encode_www_form_component(address)
  
  # API リクエスト URL の作成
  uri = URI("#{base_url}?address=#{encoded_address}&key=#{api_key}")
  
  # API にリクエストを送信
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)
  
  # 取得した緯度経度を返す
  if data['status'] == 'OK'
    lat = data['results'][0]['geometry']['location']['lat']
    lng = data['results'][0]['geometry']['location']['lng']
    return { latitude: lat, longitude: lng }
  else
    return { error: "住所のジオコーディングに失敗しました" }
  end
  end
end
