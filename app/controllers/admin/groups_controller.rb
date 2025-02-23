class Admin::GroupsController < Admin::ApplicationController
    layout "application"
    before_action :authenticate_admin! # 管理者ログインを確認
    before_action :set_group, only: [:destroy]

    def index
      @groups = Group.all

      # グループ名で検索
    if params[:search].present?
      @groups = @groups.where("name LIKE ?", "%#{params[:search]}%")
    end

    # オーナー名で検索
    if params[:owner_name].present?
      @groups = @groups.joins(:owner).where("users.name LIKE ?", "%#{params[:owner_name]}%")
    end
    # ページネーションを追加
    @groups = @groups.order(created_at: :desc)  # 作成日時で降順ソート（最近作成された順）
                        .page(params[:page])   # ページネーションを追加
                        .per(3)                # 1ページあたり3件表示
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

