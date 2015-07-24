class EventCategoryPresenter < BasePresenter
  presents :event_category
  delegate :event, to: :event

  def id
    event_category.id
  end

  def linked_title(options = {})
    h.link_to event_category.title, event_category, options
  end

  def class_name
    event_category.class.name.downcase
  end

  def title
    event_category.title
  end

  def linked_title(options = {})
    h.link_to event_category.title, events_path(event_category_id: event_category.id), options
  end
end
