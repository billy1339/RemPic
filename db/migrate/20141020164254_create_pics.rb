class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|
      t.string :picture
    end
  end
end
