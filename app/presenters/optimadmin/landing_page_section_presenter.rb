module Optimadmin
  class LandingPageSectionPresenter
    include Optimadmin::PresenterMethods

    presents :landing_page_section
    delegate :id, :title, to: :landing_page_section
  end
end
