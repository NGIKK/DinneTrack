class Admin::HomesController < ApplicationController
  def top
    @dinners = Dinner.page(params[:page]).per(10).order(created_at: :desc)
  end
end
