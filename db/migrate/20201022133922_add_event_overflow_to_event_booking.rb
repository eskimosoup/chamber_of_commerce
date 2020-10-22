class AddEventOverflowToEventBooking < ActiveRecord::Migration
  def change
    add_column :event_bookings, :booked_on_full_event, :boolean, default: false
  end
end
