module Optimadmin
  class EventCategoryPresenter < BasePresenter
    presents :event_category

    def id
      event_category.id
    end

    def name
      event_category.name
    end

    def bookable
      event_category.bookable.blank? ? 'No' : 'Yes'
    end

    def food_event
      event_category.food_event.blank? ? 'No' : 'Yes'
    end

    def has_tables
      event_category.has_tables.blank? ? 'No' : 'Yes'
    end

    def children
      event_category.children
    end
  end
end
