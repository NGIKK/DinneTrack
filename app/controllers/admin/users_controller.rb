class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(15).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @dinners = @user.dinners.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to admin_users_path, notice: "ステータスを更新しました"
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path, notice: "ユーザを削除しました"
  end

  private

   def user_params
    params.require(:user).permit(:is_deleted)
   end

end
