class SwitchNameOnEventBookingsAndAttendeesToMultipleColumns < ActiveRecord::Migration
  def up
    rename_column :event_bookings, :name, :forename
    rename_column :attendees, :name, :forename
    add_column :event_bookings, :surname, :string
    add_column :attendees, :surname, :string
  end
end
