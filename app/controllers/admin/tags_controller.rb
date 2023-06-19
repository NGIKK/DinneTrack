class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.page(params[:page]).per(15).order(created_at: :desc)
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path, notice: "タグを削除しました"
  end

end
