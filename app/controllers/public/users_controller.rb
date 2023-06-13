class Public::UsersController < ApplicationController
 before_action :ensure_guest_user, only: [:edit]
 before_action :set_user_search, only: [:index,:search]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result
  end

  def show
    @user = User.find(params[:id])
    @dinners = Dinner.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to mypage_users_path
    else
      render :edit
    end
  end

  def mypage
    @user = current_user
  end

  def favorites
   @user = User.find(params[:id])
   favorites = Favorite.where(user_id: @user.id).pluck(:dinner_id)
   @dinners = Dinner.find(favorites)
  end

end

  private

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "ゲストユーザー"
      redirect_to mypage_users_path, notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def user_params
    params.require(:user).permit(:profile_image,:name,:introduction,:genre_id)
  end

  def set_user_search
    @user_search = User.ransack(params[:user_search])
  end