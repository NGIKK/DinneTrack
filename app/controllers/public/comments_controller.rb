class Public::CommentsController < ApplicationController

  def create
    @dinner = Dinner.find(params[:dinner_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.dinner_id = @dinner.id
    @comment.save
    # redirect_to request.referer
  end

  def destroy
    @dinner = Dinner.find(params[:dinner_id])
    comment = @dinner.comments.find(params[:id])
    comment.destroy
    # redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
