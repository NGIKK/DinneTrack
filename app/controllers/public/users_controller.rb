class Public::UsersController < ApplicationController
 before_action :ensure_guest_user, only: [:edit]
 before_action :set_user_search, only: [:index]
 before_action :authenticate_user!
 before_action :ensure_correct_user, only: [:edit,:update]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(15)
  end

  def show
    @user = User.find(params[:id])
    @dinners = Dinner.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(6)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to mypage_users_path, notice: "ユーザ情報を更新しました"
    else
      render :edit
    end
  end

  def mypage
    @user = current_user
    @meal_record = MealRecord.new
    @meal_records = @user.meal_record.all
    # @edit_meal_record = MealRecord.find(params[:meal_record_id])
    @recommendations = Dinner.where(genre_id: @user.genre_id).sample(3)
  end

  def favorites
   @user = User.find(params[:id])
   favorites = Favorite.where(user_id: @user.id).pluck(:dinner_id)
   @dinners = Dinner.where(id: favorites).page(params[:page]).per(6)
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

  def ensure_correct_user
    user = User.find(params[:id])
    unless user == current_user
      redirect_to mypage_users_path(current_user)
    end
  end