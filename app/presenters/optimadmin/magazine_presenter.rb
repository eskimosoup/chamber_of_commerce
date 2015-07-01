module Optimadmin
  class MagazinePresenter < BasePresenter
    presents :magazine

    def id
      magazine.id
    end

    def name
      magazine.name
    end

    def date
      h.l magazine.date, format: :long
    end
  end
end
