class CreateEventBookings < ActiveRecord::Migration
  def change
    create_table :event_bookings do |t|
      t.belongs_to :event, index: true, foreign_key: true
      t.string :name, null: false
      t.string :company_name
      t.string :industry
      t.string :nature_of_business
      t.text :address
      t.string :phone_number
      t.string :email
      t.boolean :paid, default: false
      t.integer :attendees_count, default: 0

      t.timestamps null: false
    end
  end
end
