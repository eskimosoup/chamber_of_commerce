class EventBooking < ActiveRecord::Base
  belongs_to :event

  validates :name, :email, :phone_number, presence: true
end
