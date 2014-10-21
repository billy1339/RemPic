class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :text
      t.string :phone_number
      t.time :time #, null: false, default: Time.now
      t.string :picture
      t.belongs_to :user, index: true
      t.boolean :favorite
      t.integer :delayed_job_id
      t.timestamps
    end
  end
end
