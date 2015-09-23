class SplitEventBookingAddressIntoSeperateFields < ActiveRecord::Migration
  def up
    add_column :event_bookings, :address_line_1, :string
    add_column :event_bookings, :address_line_2, :string
    add_column :event_bookings, :town, :string
    add_column :event_bookings, :postcode, :string
    remove_column :event_bookings, :address
  end

  def down
    remove_column :event_bookings, :address_line_1
    remove_column :event_bookings, :address_line_2
    remove_column :event_bookings, :town
    remove_column :event_bookings, :postcode
    add_column :event_bookings, :address, :text
  end
end
