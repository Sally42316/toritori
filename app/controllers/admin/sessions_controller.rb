# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController

  # 管理者がログインした後の遷移先を指定
  def after_sign_in_path_for(resource)
    admin_comments_url
    # admin_root_path  # /admin/homes/top にリダイレクトされます
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
