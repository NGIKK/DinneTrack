class Admin::HomesController < ApplicationController
  def top
    @dinners = Dinner.page(params[:page]).per(15).order(created_at: :desc)
  end
end
