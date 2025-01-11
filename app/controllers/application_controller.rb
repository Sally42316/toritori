class ApplicationController < ActionController::Base
    before_action :authenticate_user!, except: [:top, :about] # top, about の2つのアクションのみ、ログイン無しでもアクセス可能にする
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    root_path # ログインした直後は、"/"に遷移
  end

  


  protected
  def configure_permitted_parameters
    #一般ユーザーログイン
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    # :sign_up の際に :name パラメータも許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name])
    
    # :account_update の際にも :name パラメータを許可する（プロフィール編集時に名前を更新可能にする）
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
