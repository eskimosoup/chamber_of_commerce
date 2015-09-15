module Optimadmin
  class EventOfficePresenter < Optimadmin::BasePresenter
    presents :event_office

    def id
      event_office.id
    end

    def title
      event_office.name
    end

    def toggle_title
      inline_detail_toggle_link(event_office.name)
    end

    def optimadmin_summary
      event_office.email
    end
  end
end
