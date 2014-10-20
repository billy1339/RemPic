class RemindersController < ApplicationController
  before_action :authenticate_user!, except: [:index]


  def index
    @user = current_user
  end

  def new
    @user = current_user
    @reminder = Reminder.new
  end

  def create
    @reminder = Reminder.create(reminder_params)
    @reminder.user = current_user
    @reminder.save
    redirect_to reminders_path
  end


  private

  def reminder_params
    params.require(:reminder).permit(:text, :phone_number, :time, :picture)
  end


end
