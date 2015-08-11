class Attendee < ActiveRecord::Base
  belongs_to :event_booking, counter_cache: true
end
