class Admin::DinnersController < ApplicationController

  def show
    @dinner = Dinner.find(params[:id])
  end

  def destroy
    dinner = Dinner.find(params[:id])
    dinner.destroy
    redirect_to "/admin"
  end

end
