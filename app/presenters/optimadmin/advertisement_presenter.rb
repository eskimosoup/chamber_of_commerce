module Optimadmin
  class AdvertisementPresenter
    include Optimadmin::PresenterMethods

    presents :advertisement
      delegate :id, :name, to: :advertisement

    def toggle_title
      inline_detail_toggle_link(name)
    end

    def optimadmin_summary
      # h.simple_format advertisement.summary
    end

    def date(date)
      h.l date, format: :short if date
    end
  end
end
