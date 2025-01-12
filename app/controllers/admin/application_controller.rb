class Admin::ApplicationController < ActionController::Base
    before_action :authenticate_admin!  # 管理者の認証を強制
  
    # 必要に応じて、他の共通処理を追加できます。
end