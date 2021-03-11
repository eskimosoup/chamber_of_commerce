module Optimadmin
  class Memberships::GroupPresenter
    include Optimadmin::PresenterMethods

    presents :group
    delegate :id, :title, to: :group
  end
end
