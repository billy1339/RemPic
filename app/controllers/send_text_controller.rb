class SendTextController < ApplicationController

  def index
  end

  def send_text_message
    number_to_send_to = params[:number_to_send_to]

    twilio_sid = ACCOUNT_SID
    twilio_token = AUTH_TOKEN
    twilio_phone_number = "+18607852739"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.messages.create(
      :from => :twilio_phone_number,
      :to => :number_to_send_to,
      :body => "tester message"
      )


  end
end
