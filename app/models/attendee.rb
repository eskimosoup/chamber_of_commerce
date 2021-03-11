# == Schema Information
#
# Table name: attendees
#
#  id                   :integer          not null, primary key
#  dietary_requirements :text
#  email                :string
#  forename             :string
#  phone_number         :string
#  surname              :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  event_booking_id     :integer
#
# Indexes
#
#  index_attendees_on_event_booking_id  (event_booking_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_booking_id => event_bookings.id)
#
class Attendee < ActiveRecord::Base

  CSV_FIELDS = %w{ forename surname email phone_number dietary_requirements }
  CSV_HEADERS = CSV_FIELDS.map{|x| "Attendee #{ x.split("_").map(&:titleize).join(" ") }" }
  belongs_to :event_booking, counter_cache: true
  has_many :attendee_event_agendas, dependent: :destroy
  has_many :event_agendas, through: :attendee_event_agendas

  validates :attendee_event_agendas, :forename, :surname, presence: true

  def agendas_total_price
    attendee_event_agenda_prices.reduce(:+)
  end

  def agenda_ids
    attendee_event_agendas.map(&:event_agenda_id)
  end

  def csv_attributes
    CSV_FIELDS.map{|attr| send(attr) }
  end

  def event_agenda_names
    event_agendas.pluck(:name).join(", ")
  end

  private

  def attendee_event_agenda_prices
    attendee_event_agendas.map(&:price)
  end

end
