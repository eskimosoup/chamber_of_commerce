class AddPaymentMethodToEventBookings < ActiveRecord::Migration
  def change
    add_column :event_bookings, :payment_method, :string
  end
end
