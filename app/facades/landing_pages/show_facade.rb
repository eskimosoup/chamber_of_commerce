module LandingPages
  class ShowFacade
    def initialize(landing_page)
      @landing_page = landing_page
    end

    def landing_page_sections
      @landing_page_sections ||= landing_page.landing_page_sections.displayed.ordered
    end

    attr_reader :landing_page
  end
end
