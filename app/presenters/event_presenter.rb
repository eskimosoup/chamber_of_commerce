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

  def linked_truncated_title(options = {}, truncate_length = 136)
    h.link_to (h.truncate(name, length: truncate_length)), event, options
  end

  def dates
    return h.raw h.content_tag(:strong, start_date) unless event.end_date
    if event.end_date == event.start_date
      h.raw "Date <strong>#{start_date}</strong>"
    else
      h.raw [wrapped_start_date, wrapped_end_date].compact.join(" ")
    end
  end

  def title
    name
  end

  def date(format = :long)
    h.l event.start_date, format: format
  end

  def start_date(format = :long)
    h.l event.start_date, format: format
  end

  def end_date(format = :long)
    h.l event.end_date, format: format if event.end_date
  end

  def location
    h.link_to event.event_location.location_name, event.event_location, title: event.event_location.location_name
  end

  def location_address
    event.event_location.address
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
    return nil unless event.image.present?
    h.content_tag :div, (image_from_layout + image_caption), class: "#{'image-right' if event.layout == 'right_image'}"
  end

  def image_caption
    h.content_tag :p, event.caption, class: 'article-caption' if event.caption.present?
  end

  def image_from_layout
    case event.layout
      when "full_image"
        h.image_tag event.image.show_full_image, alt: name, class: 'page-image'
      else
        h.image_tag event.image.show, alt: name, class: 'page-image'
    end
  end

  def linked_home_image
    h.link_to event, title: name do
      if event.image?
        h.image_tag event.image.homepage, alt: name
      else
        h.image_tag 'placeholders/home-slider.jpg', alt: name
      end
    end
  end

  def linked_index_image
    h.link_to event, title: name do
      if event.image?
        h.image_tag event.image.index, alt: name
      else
        h.image_tag 'placeholders/list-image.jpg', alt: name
      end
    end
  end

  def read_more
    h.link_to 'Read more', event, class: 'content-box-ghost-button'
  end

  def booking_button
    return nil unless event.allow_booking?
    h.link_to "Book now", booking_link, id: "book-event", class: "button" if display_booking_button?
  end

  def booking_title
    "Book #{ name }"
  end

  def booking_deadline(format = :default)
    return nil if event.booking_deadline.blank?
    h.l event.booking_deadline, format: format
  end

  private

  def booking_link
    return event.eventbrite_link if event.eventbrite_link
    h.new_event_event_booking_path(event)
  end

  def wrapped_start_date
    "Start " + h.content_tag(:strong, start_date)
  end

  def wrapped_end_date
    "End " + h.content_tag(:strong, end_date)
  end

  def display_booking_button?
    event.event_agendas.present? &&
        ((event.booking_deadline.present? && event.booking_deadline >= Time.zone.now) || event.booking_deadline.blank?)
  end
end
