class RemindersController < ApplicationController
  before_action :authenticate_user!, except: [:index]


  def index
    @user = current_user
  end

  def new
    @user = current_user
    @reminder = Reminder.new
    @favorite = Favorite.all
  end

  def pic_to_chose
  end

  def create
    @reminder = Reminder.create(reminder_params)
    @reminder.user = current_user
    @reminder.save
    # binding.pry
    # @reminder.delay.send_text_message(:time)
    # send_text_message
    schedule_sending_text
    if @reminder[:favorite] == true
      @favorite = Favorite.create(fav_params)
      @favorite[:phone_number] = @reminder[:phone_number]
      @favorite[:picture] = @reminder[:picture]
      @favorite[:user_id] = current_user.id
      @favorite.save
      # binding.pry
      # if time is left blank -- do something like Time.now.
    end
    redirect_to reminders_path

  end

   def schedule_sending_text
    Delayed::Job.enqueue(perform, :run_at => @reminder.time)

    # job = self.delay(run_at: @reminder.time).send_text_message
    # update_column(:delayed_job_id, job.id)
  end

  def perform
    send_text_message
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
    params.fetch(:favorite, {}).permit(:picture, :phone_number)
  end

  def reminder_params
    params.require(:reminder).permit(:text, :phone_number, :time, :picture, :favorite)
  end


end
