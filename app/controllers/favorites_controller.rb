class FavoritesController < ApplicationController

  def index
    @user = current_user
    @reminder = Reminder.all
    @reminder.each do |t|
      if @reminder.user_id == @user.id && @reminder.favorite == true

      end
    end
  end

  private

end
