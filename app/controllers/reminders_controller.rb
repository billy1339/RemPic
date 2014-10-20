class RemindersController < ApplicationController
  before_action :authenticate_user!, except: [:index]


  def index
    @user = current_user
  end

  def new
    @user = current_user
    @reminder = Reminder.new
  end

  def pic_to_chose
  end

  def create
    @reminder = Reminder.create(reminder_params)
    @reminder.user = current_user
    @reminder.save
    send_text_message
    # if @reminder[:favotire] == true
    # @favorite = Favorite.create(fav_params)
    # @favorite[:phone_number] = @reminder[:phone_number]
    # @favorite[:picture] = @reminder[:picture]
    # end
    redirect_to reminders_path

  end

  def send_text_message

    number_to_send_to = @reminder[:phone_number]
    message_to_send = @reminder[:text]
    picture_url = @reminder[:picture]

    twilio_sid = ENV["ACCOUNT_SID"]
    twilio_token = ENV["AUTH_TOKEN"]
    twilio_phone_number = "+18607852739"
    # binding.pry

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.messages.create(:from => twilio_phone_number, :to => number_to_send_to, :body => message_to_send, :media_url => picture_url)

  end


  private
  def fav_params
    params.require(:favorites).permit(:picture, :phone_number)
  end

  def reminder_params
    params.require(:reminder).permit(:text, :phone_number, :time, :picture, :favorite)
  end


end
