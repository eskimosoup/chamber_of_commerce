class AddStripeChargeIdToEventBookings < ActiveRecord::Migration
  def change
    add_column :event_bookings, :stripe_charge_id, :string
    add_column :event_bookings, :refunded, :boolean, default: false
  end
end
