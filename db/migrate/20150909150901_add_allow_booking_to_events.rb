class AddAllowBookingToEvents < ActiveRecord::Migration
  def change
    add_column :events, :allow_booking, :boolean, default: true
  end
end
