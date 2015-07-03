module Optimadmin
  class EventAgendaPresenter < Optimadmin::BasePresenter
    presents :event_agenda

    def id
      event_agenda.id
    end

    def name
      event_agenda.name
    end

    def start_time
      h.l event_agenda.start_time, format: :short
    end

    def end_time
      h.l event_agenda.end_time, format: :short
    end

    def category
      event_agenda.event_category.name
    end

    def content
      h.raw event_agenda.content
    end
  end
end
