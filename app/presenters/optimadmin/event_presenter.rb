module Optimadmin
  class EventPresenter < Optimadmin::BasePresenter
    presents :event
    delegate :event_location, to: :event_location

    def name
      event.name
    end

    def toggle_title
      "#{name} (#{h.l event.start_date, format: :short})"
    end

    def event_agendas
      h.link_to h.pluralize(event.event_agendas_count, "agenda"), h.event_event_agendas_path(event)
    end

    def event_bookings
      h.link_to h.pluralize(event.event_bookings.where(paid: true).size, "paid booking"), h.event_event_bookings_path(event)
    end

    def location
      event.event_location.location_name if event.event_location.present?
    end

    def description
      h.raw event.description
    end
  end
end
