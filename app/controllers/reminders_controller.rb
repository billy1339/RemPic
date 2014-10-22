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



  def create
    #this method does three things right now...creates a reminder,
    #sends a text, and creates a favorite.....
    @reminder = Reminder.create(reminder_params)
    @reminder.user = current_user
    @reminder.save
    # binding.pry
    # @reminder.delay.send_text_message(:time)
    Reminder.send_text_message(@reminder.id)
    # send_text_message

    create_favorite
    # schedule_sending_text
    #refactor this porfavor....
    # if @reminder[:favorite] == true
    #   @favorite = Favorite.create(fav_params)
    #   @favorite[:phone_number] = @reminder[:phone_number]
    #   @favorite[:picture] = @reminder[:picture]
    #   @favorite[:user_id] = current_user.id
    #   @favorite.save
    #   # binding.pry
    #   # if time is left blank -- do something like Time.now.
    # end
    # flash[:notice] = "Sucsessfully Sent!"
    redirect_to reminders_path

  end

  def create_favorite
    if @reminder[:favorite] == true
      @favorite = Favorite.create(fav_params)
      @favorite[:phone_number] = @reminder[:phone_number]
      @favorite[:picture] = @reminder[:picture]
      @favorite[:user_id] = current_user.id
      @favorite.save
      # binding.pry
      # if time is left blank -- do something like Time.now.
    end
  end

  def schedule_sending_text
    # Delayed::Job.enqueue(perform, :run_at => @reminder.time)

    # job = self.delay(run_at: @reminder.time).send_text_message
    # update_column(:delayed_job_id, job.id)
  end

  def perform
    send_text_message
  end

  # def send_text_message
  #   numbers_to_send_to = @reminder[:phone_number].split ", "
  #   # multiple_nums = number_to_send_to.split ", "
  #   message_to_send = "A reminder from Remind U: " + @reminder[:text]
  #   picture_url = @reminder[:picture]

  #   twilio_sid = ENV["ACCOUNT_SID"]
  #   twilio_token = ENV["AUTH_TOKEN"]
  #   twilio_phone_number = "+18607852739"
  #   # binding.pry

  #   @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

  #   numbers_to_send_to.each do |number|
  #     @twilio_client.account.messages.create(:from => twilio_phone_number, :to => number, :body => message_to_send, :media_url => picture_url)
  #   end
  # end


  private
  def fav_params
    params.fetch(:favorite, {}).permit(:picture, :phone_number)
  end

  def reminder_params
    params.require(:reminder).permit(:text, :phone_number, :time, :picture, :favorite)
  end


end
