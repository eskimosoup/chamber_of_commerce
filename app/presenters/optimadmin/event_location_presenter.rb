module Optimadmin
  class EventLocationPresenter < BasePresenter
    presents :event_location

    def id
      event_location.id
    end

    def location_name
      event_location.location_name
    end

    def address
      [event_location.address_line_1,
        event_location.address_line_2,
        event_location.city,
        event_location.region,
        event_location.post_code]
        .compact.reject{|x| x.empty? if x.class == String}.join(', ')
    end
  end
end
