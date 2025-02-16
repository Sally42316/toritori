class Admin::ChatsController < Admin::ApplicationController
    layout "application"
    before_action :set_group

    # GET /admin/groups/:group_id/chats
    def index
      @chats = @group.chats.includes(:user)
      @chat = Chat.new
    end

    # # POST /admin/groups/:group_id/chats
    # def create
    #   @chat = @group.chats.new(chat_params)
    #   @chat.user = current_user
    #   if @chat.save
    #     redirect_to admin_group_chats_path(@group), notice: 'メッセージが送信されました。'
    #   else
    #     @chats = @group.chats.includes(:user)
    #     render :index, status: :unprocessable_entity
    #   end
    # end

    # # DELETE /admin/groups/:group_id/chats/:id
    # def destroy
    #     @chat = @group.chats.find(params[:id])
    #     if @chat.destroy
    #       redirect_to admin_group_chats_path(@group), notice: 'メッセージを削除しました。'
    #     else
    #       redirect_to admin_group_chats_path(@group), alert: 'メッセージの削除に失敗しました。'
    #     end
    # end

    

    private

    def set_group
      @group = Group.find(params[:group_id])
    end

    def chat_params
      params.require(:chat).permit(:chat)
    end
end
