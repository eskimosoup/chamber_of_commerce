module Optimadmin
  class EventPresenter < Optimadmin::BasePresenter
    presents :event
    delegate :event_location, to: :event_location

    def id
      event.id
    end

    def name
      event.name
    end

    def event_agendas
      h.link_to "Event Agendas (#{event.event_agendas.count})", h.event_agendas_path(event_id: event.id)
    end

    def location
      event.event_location.location_name
    end

    def description
      h.raw event.description
    end
  end
end
