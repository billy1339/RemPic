class Reminder < ActiveRecord::Base
  belongs_to :user
  has_one :favorite

end
