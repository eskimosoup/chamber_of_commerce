module Optimadmin
  class Memberships::EnquiryPresenter
    include Optimadmin::PresenterMethods

    presents :enquiry
    delegate :id, :title, :full_name, :company_name, to: :enquiry

    def submitted
      h.l(enquiry.created_at, format: :long)
    end

    def view_link
      h.link_to(eye, enquiry)
    end
  end
end
