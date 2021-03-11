module Memberships
  class HomesController < BaseController
    def index
      @facade = ::Memberships::Homes::IndexFacade.new
      @enquiry = ::Memberships::Enquiry.new
      @payment = ::Memberships::Payment.new
    end
  end
end
