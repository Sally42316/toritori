class GroupsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update]
  
    def index
      if params[:q].present?
        @groups = Group.search(params[:q]).where.not(owner_id: User.where(is_deleted: true).pluck(:id)) # オーナーが削除されていないグループを取得
      else
        @groups = Group.where.not(owner_id: User.where(is_deleted: true).pluck(:id)) # オーナーが削除されていないグループを取得
      end
      
      # オーナーがnilの場合や削除されているグループを除外
      @groups = @groups.reject { |group| group.owner.nil? || group.owner.is_deleted? }
    
      @user = current_user
    end
  
    def show
      @group = Group.find(params[:id])
      if @group.owner.nil? || @group.owner.is_deleted?
        @group.destroy
        redirect_to groups_path, notice: 'オーナーが削除されているため、グループは削除されました。'
      end
    end
  
    def new
      @group = Group.new
    end
  
    def create
      @group = Group.new(group_params)
      @group.owner_id = current_user.id
      if @group.save
        redirect_to groups_path, method: :post
      else
        render 'new'
      end
    end
  
    def edit
    @group = Group.find(params[:id])
    end
  
    def update
      if @group.update(group_params)
        redirect_to groups_path
      else
        render "edit"
      end
    end

    def destroy
      @group = Group.find(params[:id])
      if @group.destroy
        flash[:notice] = 'グループを削除完了'
      else
        flash[:alert] = 'グループを削除不可'
      end
      redirect_to groups_path
    end

    def my_groups
      # ユーザーが参加しているグループと作成したグループを両方取得
      # オーナーが削除されていないグループのみを取得
      @groups = current_user.groups + Group.where(owner_id: current_user.id).where.not(owner_id: User.where(is_deleted: true).pluck(:id))
    end
  
    private
  
    def group_params
      params.require(:group).permit(:name, :detail, :image)
    end
  
    def ensure_correct_user
      @group = Group.find(params[:id])
      unless @group.owner_id == current_user.id
        redirect_to groups_path
      end
    end
end
