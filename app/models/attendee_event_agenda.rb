class AttendeeEventAgenda < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :event_agenda

  before_validation :set_price

  private

  def set_price
    self.price = event_agenda.price if event_agenda
  end
end
