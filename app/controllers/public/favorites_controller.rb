class Public::FavoritesController < ApplicationController

 def create
   dinner = Dinner.find(params[:dinner_id])
   favorite = current_user.favorites.new(dinner_id: dinner.id)
   favorite.save
   redirect_to request.referer
 end

 def destroy
   dinner = Dinner.find(params[:dinner_id])
   favorite = current_user.favorites.find_by(dinner_id: dinner.id)
   favorite.destroy
   redirect_to request.referer
 end

end
