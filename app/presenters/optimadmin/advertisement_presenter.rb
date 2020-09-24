module Optimadmin
  class AdvertisementPresenter
    include Optimadmin::PresenterMethods

    presents :advertisement
      delegate :id, :name, to: :advertisement

    def toggle_title
      name
    end

    def optimadmin_summary
      # h.simple_format advertisement.summary
    end

    def date(date)
      date
    end
  end
end
