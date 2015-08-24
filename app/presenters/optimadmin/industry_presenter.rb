module Optimadmin
  class IndustryPresenter < Optimadmin::BasePresenter
    presents :industry

    def name
      industry.name
    end
  end
end