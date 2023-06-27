class Admin::CommentsController < ApplicationController

  def destroy
    dinner = Dinner.find(params[:dinner_id])
    comment = dinner.comments.find(params[:id])
    comment.destroy
    redirect_to request.referer, notice: "コメントを削除しました"
  end
end
