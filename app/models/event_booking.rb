class EventBooking < ActiveRecord::Base

  belongs_to :event
  has_many :attendees, dependent: :destroy
  accepts_nested_attributes_for :attendees, reject_if: :all_blank, allow_destroy: true

  scope :paid, ->{ where(paid: true) }

  validates :name, :email, :phone_number, presence: true
  validates :attendees, presence: true

  def price
    attendee_prices.reduce(:+)
  end

  def stripe_price
    (price * 100).to_i
  end

  private

  def attendee_prices
    attendees.map(&:agendas_total_price)
  end

end
