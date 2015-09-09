module Optimadmin
  class MemberOfferPresenter < Optimadmin::BasePresenter
    presents :member_offer

    def title
      member_offer.title
    end

    def toggle_title
      inline_detail_toggle_link(member_offer.member.company_name)
    end

    def image
      member_offer.image
    end

    def member
      member_offer.member
    end

    def description
      h.raw member_offer.description
    end

    def summary
      h.simple_format member_offer.summary
    end
  end
end
