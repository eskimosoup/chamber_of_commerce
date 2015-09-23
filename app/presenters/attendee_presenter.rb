class AttendeePresenter < BasePresenter
  presents :attendee

  def phone_number
    attendee.phone_number
  end

  def name
    attendee.name
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
        h.concat(h.content_tag(:li, event_agenda.name))
      end
    end
  end

end