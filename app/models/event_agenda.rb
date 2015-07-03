class EventAgenda < ActiveRecord::Base
  belongs_to :event_category
  belongs_to :event, counter_cache: true
end
