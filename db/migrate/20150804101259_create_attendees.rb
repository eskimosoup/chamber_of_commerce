class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.belongs_to :event_booking, index: true, foreign_key: true
      t.string :phone_number
      t.string :email
      t.text :dietary_requirements

      t.timestamps null: false
    end
  end
end
