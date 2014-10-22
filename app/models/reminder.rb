class Reminder < ActiveRecord::Base
  belongs_to :user

  # Delayed::Job.enqueue :delayed_jobs, :queue => 'tracking'

  # def self.schedule_sending_text
  #   job = self.delay(run_at: Time.now).send_text_message
  #   update_column(:delayed_job_id, job.id)
  # end



end
