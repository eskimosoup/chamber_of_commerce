class EventPresenter < BasePresenter
  presents :event
  delegate :id, :name, to: :event
  delegate :event_location, to: :event_location

  def event_categories
    event.event_categories
  end

  def event_agendas
    event.event_agendas
  end

  def event_bookings
    event.event_bookings
  end

  def class_name
    event.class.name.downcase
  end

  def linked_title(options = {})
    h.link_to name, event, options
  end

  def dates
    return h.content_tag(:strong, start_date) unless event.end_date
    [wrapped_start_date, wrapped_end_date].compact.join(" ")
  end

  def start_date(format = :long)
    h.l event.start_date, format: format
  end

  def end_date(format = :long)
    h.l event.end_date, format: format
  end

  def location
    h.link_to event.event_location.location_name, event.event_location, title: event.event_location.location_name
  end

  def summary
    h.simple_format event.summary
  end

  def description
    h.raw event.description
  end

  def booking_confirmation_information
    h.raw event.booking_confirmation_information
  end

  def image
    h.image_tag event.image.show, alt: event.name, class: 'page-image image-right' if event.image?
  end

  def linked_home_image
    h.link_to event, title: event.name do
      if event.image?
        h.image_tag event.image.homepage, alt: event.name
      else
        h.image_tag 'placeholders/home-slider.jpg', alt: event.name
      end
    end
  end

  def linked_index_image
    h.link_to event, title: event.name do
      if event.image?
        h.image_tag event.image.index, alt: event.name
      else
        h.image_tag 'placeholders/list-image.jpg', alt: event.name
      end
    end
  end

  def read_more
    h.link_to 'Read more', event, class: 'content-box-ghost-button'
  end

  def booking_button
    return nil unless event.allow_booking?
    h.link_to "Book now", booking_link, id: "book-event", class: "button"
  end

  def booking_title
    "Book #{ name }"
  end

  private

  def booking_link
    return event.eventbrite_link if event.eventbrite_link
    h.new_event_event_booking_path(event)
  end

  def wrapped_start_date
    "Start " + h.content_tag(:strong, end_date)
  end

  def wrapped_end_date
    "End " + h.content_tag(:strong, end_date)
  end
end
