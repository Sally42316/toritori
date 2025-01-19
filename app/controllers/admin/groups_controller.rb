class Admin::GroupsController < Admin::ApplicationController
    layout "application"
    before_action :authenticate_admin! # 管理者ログインを確認
    before_action :set_group, only: [:destroy]

    def index
      @groups = Group.all
    end

    def destroy
      if @group.destroy
        flash[:notice] = "グループ「#{@group.name}」を削除しました。"
      else
        flash[:alert] = "グループの削除に失敗しました。"
      end
      redirect_to admin_groups_path
    end


    private

    def set_group
      @group = Group.find(params[:id])
    end
  end

