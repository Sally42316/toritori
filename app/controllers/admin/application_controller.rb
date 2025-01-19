class Admin::ApplicationController < ActionController::Base
    before_action :authenticate_admin!  # 管理者の認証を強制
  
    # 必要に応じて、他の共通処理を追加できます。
    private

    def authenticate_admin!
        unless current_admin
          redirect_to new_admin_session_path, alert: "管理者権限が必要です。"
        end
    end
end