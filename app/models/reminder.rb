class Reminder < ActiveRecord::Base
  belongs_to :user

  # Delayed::Job.enqueue :delayed_jobs, :queue => 'tracking'

  # def self.schedule_sending_text
  #   job = self.delay(run_at: Time.now).send_text_message
  #   update_column(:delayed_job_id, job.id)
  # end
  def self.send_text_message1(remind)
    numbers_to_send_to = remind[:phone_number].split ", "
    # multiple_nums = number_to_send_to.split ", "
    message_to_send = "A reminder from Remind U: " + remind[:text]
    picture_url = remind[:picture]

    twilio_sid = ENV["ACCOUNT_SID"]
    twilio_token = ENV["AUTH_TOKEN"]
    twilio_phone_number = "+18607852739"
    # binding.pry

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    numbers_to_send_to.each do |number|
      @twilio_client.account.messages.create(:from => twilio_phone_number, :to => number, :body => message_to_send, :media_url => picture_url)
    end
  end


end
