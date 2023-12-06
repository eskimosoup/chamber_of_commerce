module Optimadmin
  class EventGroupPresenter
    include Optimadmin::PresenterMethods

    presents :event_group
    delegate :id, :title, to: :event_group
  end
end
