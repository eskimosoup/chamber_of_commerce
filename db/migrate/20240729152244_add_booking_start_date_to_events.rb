class AddBookingStartDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :booking_start_date, :datetime
  end
end
