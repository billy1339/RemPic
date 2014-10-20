class PicsController < ApplicationController

  def index
    @user = current_user
    @pic = Pic.new
  end

end
