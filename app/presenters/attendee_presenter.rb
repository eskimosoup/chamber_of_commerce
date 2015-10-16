class AttendeePresenter < BasePresenter
  presents :attendee

  def phone_number
    attendee.phone_number
  end

  def forename
    attendee.forename
  end

  def surname
    attendee.surname
  end

  def name
    [forename, surname].compact.join(" ")
  end

  def email
    attendee.email
  end

  def dietary_requirements
    attendee.dietary_requirements
  end

  def event_agendas
    h.content_tag :ul do
      attendee.event_agendas.map do |event_agenda|
        h.concat(h.content_tag(:li, "#{event_agenda.name} <br /> #{event_agenda_start(event_agenda)} - #{event_agenda_end(event_agenda)}".html_safe))
      end
    end
  end

  private

    def event_agenda_start(event_agenda)
      h.l event_agenda.start_time, format: :short
    end

    def event_agenda_end(event_agenda)
      h.l event_agenda.end_time, format: :short
    end

end
