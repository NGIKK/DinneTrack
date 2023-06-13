class Admin::HomesController < ApplicationController
  def top
    @dinners = Dinner.all
  end
end
