# == Schema Information
#
# Table name: event_bookings
#
#  id                       :integer          not null, primary key
#  address_line_1           :string
#  address_line_2           :string
#  attendees_count          :integer          default(0)
#  booked_on_full_event     :boolean          default(FALSE)
#  company_name             :string
#  email                    :string
#  forename                 :string           not null
#  industry                 :string
#  nature_of_business       :string
#  paid                     :boolean          default(FALSE)
#  payment_method           :string
#  phone_number             :string
#  postcode                 :string
#  refunded                 :boolean          default(FALSE)
#  surname                  :string
#  town                     :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  event_id                 :integer
#  stripe_charge_id         :string
#  stripe_payment_intent_id :string
#
# Indexes
#
#  index_event_bookings_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
class EventBooking < ActiveRecord::Base

  CSV_ATTRIBUTES = ["forename", "surname", "company_name", "industry", "nature_of_business", "email", "phone_number",
                  "address_line_1", "address_line_2", "town", "postcode", "paid", "refunded", "payment_method", "booked_on_full_event"]
  CSV_HEADERS = ["Event Booking Id", "Booking Date"].push(*CSV_ATTRIBUTES.map{|x| x.split("_").map(&:titleize).join(" ") })

  belongs_to :event, counter_cache: true
  has_many :event_agendas, through: :event
  has_many :attendees, dependent: :destroy
  accepts_nested_attributes_for :attendees, reject_if: :all_blank, allow_destroy: true

  scope :paid, ->{ where(paid: true) }
  scope :paid_not_refunded, ->{ paid.where("refunded != ?", true) }
  scope :unpaid_or_refunded, ->{ where("paid != :true OR refunded = :true", true: true) }
  scope :unpaid, ->{ where("paid != :true", true: true) }

  validates :forename, :surname, :email, :phone_number, presence: true
  validates :attendees, presence: true
  validate :agendas_available, on: :create
  validates :stripe_charge_id, presence: true, on: :update, unless: :paid?

  def price
    price_calculator.price
  end

  def stripe_price
    price_calculator.stripe_price
  end

  def agendas_available
    return nil if event.blank? || event.event_agendas.blank? || event.event_agendas.size <= 2
    event.event_agendas.each do |event_agenda|
      errors.add(:base, "#{ event_agenda.name } only has #{ event_agenda.open_spaces } spaces") if event_agenda.full?(agenda_id_frequency[event_agenda.id])
    end
  end

  def event_full?
    event.event_agendas.size <= 2 && event.event_agendas.map { |agenda| agenda.full?(agenda_id_frequency[agenda.id]) }.include?(true)
  end

  def attendee_event_agenda_ids
    attendees.map(&:agenda_ids).flatten
  end

  def agenda_id_frequency
    @agenda_id_frequency ||= attendee_event_agenda_ids.each_with_object(Hash.new(0)) {|id, result| result[id] += 1 }
  end

  def csv_attributes
    attrs = [id, created_at.strftime("%Y-%m-%d %H:%M:%S+%H:%M")]
    attrs.push(*attributes.values_at(*CSV_ATTRIBUTES))
    attrs
  end


  private

  def price_calculator
    EventBooking::PriceCalculator.new(attendees: attendees)
  end

end
