module Optimadmin
  module Memberships
    class JoinReasonPresenter
      include Optimadmin::PresenterMethods

      presents :join_reason
      delegate :id, :title, to: :join_reason
    end
  end
end
