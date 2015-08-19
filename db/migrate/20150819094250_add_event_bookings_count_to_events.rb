class AddEventBookingsCountToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_bookings_count, :integer, default: 0
    Event.find_each do |event|
      Event.reset_counters(event.id, :event_bookings)
    end
  end
end
