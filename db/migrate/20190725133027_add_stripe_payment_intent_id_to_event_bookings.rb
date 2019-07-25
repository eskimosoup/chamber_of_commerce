class AddStripePaymentIntentIdToEventBookings < ActiveRecord::Migration
  def change
    add_column :event_bookings, :stripe_payment_intent_id, :string
  end
end
