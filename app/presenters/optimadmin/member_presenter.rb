module Optimadmin
  class MemberPresenter < Optimadmin::BasePresenter
    presents :member

    delegate :chamber_db_id, to: :member

    def member_logins
      member.member_login
    end

    def title
      member.company_name  if member.company_name.present?
    end

    def toggle_title
      title
    end

    def edit_member_login
      # h.link_to 'Edit', h.edit_member_member_login_path(member, member.member_login)
    end
  end
end
