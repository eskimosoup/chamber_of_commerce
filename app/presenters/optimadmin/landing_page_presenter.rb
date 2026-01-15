module Optimadmin
  class LandingPagePresenter
    include Optimadmin::PresenterMethods

    presents :landing_page
    delegate :id, :title, to: :landing_page

    def manage_sections
      h.link_to(
        'Manage sections',
        h.landing_page_landing_page_sections_path(landing_page)
      )
    end
  end
end
