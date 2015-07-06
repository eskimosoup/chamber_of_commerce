class EventPresenter < BasePresenter
  presents :event
  delegate :event_location, to: :event_location

  def id
    event.id
  end

  def class_name
    event.class.name.downcase
  end

  def name
    event.name
  end

  def linked_title(options = {})
    h.link_to name, event, options
  end

  def date(format = :long)
    h.l event.start_date, format: format
  end

  def start_date(format = :long)
    h.l event.start_date, format: format
  end

  def end_date
    h.l event.start_date, format: :long
  end

  def event_agendas
    h.link_to "Event Agendas (#{event.event_agendas.count})", h.event_agendas_path(event_id: event.id)
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
      elsif placeholder.present?
        h.image_tag 'placeholders/home-slider.jpg', alt: event.name
      end
    end
  end
end
