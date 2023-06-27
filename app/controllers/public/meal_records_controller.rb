class Public::MealRecordsController < ApplicationController
 before_action :authenticate_user!

  def create
    meal_record = MealRecord.new(meal_record_params)
    meal_record.user_id = current_user.id
    if meal_record.save
      redirect_to mypage_users_path, notice: "食事記録を登録しました"
    else
      @user = current_user
      @meal_record = MealRecord.new(meal_record_params)
      @meal_records = MealRecord.all
      @recommendations = Dinner.where(genre_id: @user.genre_id).sample(3)
      redirect_to request.referer, notice: "[error!]日付と金額は必須項目です。0円の場合は0を入力してください。"
    end
  end

  # def update
  #     meal_record = MealRecord.find(params[:id])
  #   if meal_record.update(meal_record_params)
  #     redirect_to user_mypage_path
  #   else
  #     @meal_record = MealRecord.new(meal_record_params)
  #     @meal_records = MealRecord.all
  #     @recommendations = Dinner.where(genre_id: @user.genre_id).sample(3)
  #     render template: "public/users/mypage"
  #   end
  # end

  def destroy
    meal_record = MealRecord.find(params[:id])
    meal_record.destroy
    redirect_to mypage_users_path, notice: "食事記録を削除しました"
  end

end

  private

  def meal_record_params
    params.require(:meal_record).permit(:user_id,:breakfast_memo, :breakfast_cost,:lunch_memo,
                                         :lunch_cost, :dinner_memo, :dinner_cost, :snack_memo,
                                         :snack_cost, :something_memo, :something_cost, :track_date)
  end

