# == Schema Information
#
# Table name: attendee_event_agendas
#
#  id              :integer          not null, primary key
#  price           :decimal(8, 2)    default(0.0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  attendee_id     :integer
#  event_agenda_id :integer
#
# Indexes
#
#  index_attendee_event_agendas_on_attendee_id      (attendee_id)
#  index_attendee_event_agendas_on_event_agenda_id  (event_agenda_id)
#
# Foreign Keys
#
#  fk_rails_...  (attendee_id => attendees.id)
#  fk_rails_...  (event_agenda_id => event_agendas.id)
#
FactoryGirl.define do
  factory :attendee_event_agenda do
    attendee
    event_agenda
    price "9.99"
  end

end
