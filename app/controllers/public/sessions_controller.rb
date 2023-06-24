# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
   before_action :configure_sign_in_params, if: :devise_controller?
   before_action :user_state, only: [:create]

  def after_sign_in_path_for(resource)
    mypage_users_path
  end

  def after_sign_out_path_for(resource)
    mypage_users_path
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to mypage_users_path, notice:'ゲストユーザーでログインしました'
  end

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
   def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
   end

   def user_state
    @user = User.find_by(email: params[:user][:email])
    return if !@user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
        flash[:notice] = "現在アカウントのご利用が停止されております。新規ユーザ登録を行うか、運営までお問い合わせください。"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
   end
end
