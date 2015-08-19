module Optimadmin
  class PatronPresenter < Optimadmin::BasePresenter
    presents :patron

    def name
      patron.name
    end

  end
end
