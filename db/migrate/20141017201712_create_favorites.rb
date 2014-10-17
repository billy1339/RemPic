class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :phone_number
      t.belongs_to :user, index: true
      t.string :picture
    end
  end
end
