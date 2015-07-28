module Optimadmin
  class MemberPresenter < Optimadmin::BasePresenter
    presents :member

    def id
      member.id
    end

    def title
      member.company_name
    end
  end
end
