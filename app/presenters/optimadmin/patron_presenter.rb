module Optimadmin
  class PatronPresenter < BasePresenter
    presents :patron

    def id
      patron.id
    end

    def name
      patron.name
    end

  end
end
