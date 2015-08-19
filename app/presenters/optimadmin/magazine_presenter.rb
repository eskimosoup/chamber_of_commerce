module Optimadmin
  class MagazinePresenter < Optimadmin::BasePresenter
    presents :magazine

    def name
      magazine.name
    end

    def date
      h.l magazine.date, format: :long
    end
  end
end
