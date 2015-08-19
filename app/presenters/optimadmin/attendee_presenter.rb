module Optimadmin
  class AttendeePresenter < BasePresenter
    presents :attendee

    def phone_number
      attendee.phone_number
    end

    def email
      h.mail_to attendee.email if attendee.email?
    end

    def dietary_requirements
      h.simple_format attendee.dietary_requirements if attendee.dietary_requirements
    end

    def event_agendas
      @event_agendas ||= Optimadmin::BaseCollectionPresenter.new(collection: attendee.event_agendas, view_template: h, presenter: Optimadmin::EventAgendaPresenter)
    end
  end
end