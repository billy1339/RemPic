class Favorite < ActiveRecord::Base
  belongs_to :user


  def self.create_favorite(reminder_id, fav_params, current_user_id)
    reminder = Reminder.find (reminder_id)
    if reminder[:favorite] == true
      # @user = current_user
      # @user = current_user
      @favorite = Favorite.create(fav_params)
      @favorite[:phone_number] = reminder[:phone_number]
      @favorite[:picture] = reminder[:picture]
      @favorite[:user_id] = current_user_id
      @favorite.save
      # binding.pry
      # if time is left blank -- do something like Time.now.
    end
  end


  def fav_params
    # params.require(:favorite).permit(:picture, :phone_number)
    params.fetch(:favorite, {}).permit(:picture, :phone_number)
  end
end
