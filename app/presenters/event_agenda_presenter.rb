class EventAgendaPresenter < BasePresenter
  presents :event_agenda

  def name
    event_agenda.name
  end

  def start_time(format)
    return nil if event_agenda.start_time.nil?
    h.l event_agenda.start_time, format: format
  end

  def end_time(format)
    return nil if event_agenda.end_time.nil?
    h.l event_agenda.end_time, format: format
  end

  def event_category_name
    return nil if event_category.nil?
    event_category.name
  end

  private

  def event_category
    event_agenda.event_category
  end
end