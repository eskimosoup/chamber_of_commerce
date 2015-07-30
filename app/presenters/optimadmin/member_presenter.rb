module Optimadmin
  class MemberPresenter < Optimadmin::BasePresenter
    presents :member

    def id
      member.id
    end

    def title
      member.company_name
    end

    def edit_member_login
      h.link_to 'Edit', h.edit_member_member_login_path(member, member.member_login) if member.member_login.present?
    end
  end
end