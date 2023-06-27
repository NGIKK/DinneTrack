class Public::DinnersController < ApplicationController
   before_action :authenticate_user!
   before_action :ensure_correct_user, only: [:edit,:update]

  def index
      @q = Dinner.ransack(params[:q])
      @user = current_user
      if params[:followings_dinner]
        @user = current_user
        @dinners = @q.result.where(user_id: @user.followings.ids).page(params[:page]).per(4).order(created_at: :desc)
      else
       @dinners = @q.result.page(params[:page]).per(4).order(created_at: :desc)
       @user = current_user
      end
  end

  def new
    @dinner = Dinner.new
  end

  def create
    @dinner = Dinner.new(dinner_params)
    @dinner.user_id = current_user.id
    if @dinner.save
      redirect_to dinner_path(@dinner.id), notice: "夕食を投稿しました"
    else
      render :new
    end
  end

  def show
    @dinner = Dinner.find(params[:id])
    @comment = Comment.new
    @user = @dinner.user
  end

  def edit
    @dinner = Dinner.find(params[:id])
    # byebug
  end

  def update
    dinner = Dinner.find(params[:id])
    if dinner.update(dinner_params)
      redirect_to dinner_path(dinner.id), notice: "投稿内容を編集しました"
    else
      render :edit
    end
  end

  def destroy
    dinner = Dinner.find(params[:id])
    dinner.destroy
    redirect_to user_path(current_user.id), notice: "投稿を削除しました"
  end

  def album
     @genres = Genre.all
     @dinners = Dinner.where(is_posted: true).page(params[:page]).per(6)
  end

  def genre_search
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @dinners = @genre.dinners.where(is_posted: true).page(params[:page]).per(6)
  end

  private

  def dinner_params
    params.require(:dinner).permit(:dinner_image,:user_id,:genre_id,:title,:cost,:memo,:style,:is_posted,
                                   tags_attributes: [:id,:name],tag_ids: [])
  end

  def ensure_correct_user
    dinner = Dinner.find(params[:id])
     unless dinner.user == current_user
       redirect_to dinners_path
     end
   end

end
