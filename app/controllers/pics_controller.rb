class PicsController < ApplicationController

  def index
    @user = current_user
    @pic = Pic.new

  end

  def show
  end

  def create
    @pic = Pic.create(pic_params)
    @pic.save
    redirect_to pics_path
  end


  private
  def pic_params
    params.require(:pic).permit(:picture)
  end

end
