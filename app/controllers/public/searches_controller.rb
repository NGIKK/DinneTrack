class Public::SearchesController < ApplicationController
  def search
    if params[:tags].present?
      tag_names = params[:tags].split(' ')
      # テーブル結合してdinnerをタグ名1つ1つで検索し取得
      # 検索にヒットしたdinnerのレコードをdinner.idでグループ化し集計、
      # 集計した数がタグ名の数と一致したものだけ返す。
      dinners = Dinner.joins(:tags).where(tags: { name: tag_names }).group(:id).having('COUNT(*) = ?', tag_names.size)
      @album_dinners = dinners.where(is_posted: true)
    else
      @album_dinners = Dinner.where(is_posted: true)
    end
  end
end