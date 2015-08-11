class EventBooking < ActiveRecord::Base
  belongs_to :event
  has_many :attendees, dependent: :destroy
  accepts_nested_attributes_for :attendees, reject_if: :all_blank, allow_destroy: true

  validates :name, :email, :phone_number, presence: true
  validates :attendees, length: { minimum: 1 }
end
