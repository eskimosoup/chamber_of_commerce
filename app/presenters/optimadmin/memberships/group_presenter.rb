module Optimadmin
  class Memberships::GroupPresenter
    include Optimadmin::PresenterMethods

    presents :group
    delegate :id, :title, to: :group

    def view_link
      h.link_to(eye, h.main_app.memberships_group_path(group))
    end
  end
end
