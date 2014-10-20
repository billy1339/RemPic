class FavoritesController < ApplicationController

  def index
    @user = current_user
    @reminder = Reminder.all
    @reminder.each do |t|
      if t.user_id == @user.id && t.favorite == true
        @favorite = Favorite.create(fav_params)
        @favorite[:picture] = t.picture
        @favorite[:phone_number] = t.phone_number
      end
    end
  end

  def new
    @favorite = Favorite.new
  end

  private
  def fav_params
    params.fetch(:favorite, {}).permit(:picture, :phone_number)
  end
end
