class Favorite < ActiveRecord::Base
  belongs_to :user


  # def self.create_favorite1(remind)
  #   if remind[:favorite] == true
  #     # @user = current_user
  #     @favorite = Favorite.create(params.fetch(:favorite, {}).permit(:picture, :phone_number) #fav_params)
  #     @favorite[:phone_number] = remind[:phone_number]
  #     @favorite[:picture] = remind[:picture]
  #     @favorite[:user_id] = current_user.id
  #     @favorite.save
  #     # binding.pry
  #     # if time is left blank -- do something like Time.now.
  #   end
  # end


  # def fav_params
  #   params.fetch(:favorite, {}).permit(:picture, :phone_number)
  # end
end
