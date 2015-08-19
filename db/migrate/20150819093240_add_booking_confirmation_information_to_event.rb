class AddBookingConfirmationInformationToEvent < ActiveRecord::Migration
  def change
    add_column :events, :booking_confirmation_information, :text
  end
end
