class AddBookingDeadlineToEvent < ActiveRecord::Migration
  def change
    add_column :events, :booking_deadline, :datetime
  end
end
