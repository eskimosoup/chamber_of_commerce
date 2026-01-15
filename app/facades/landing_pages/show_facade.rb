module LandingPages
  class ShowFacade
    def initialize(landing_page)
      @landing_page = landing_page
    end

    attr_reader :landing_page
  end
end
