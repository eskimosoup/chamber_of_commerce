module Optimadmin
  class Memberships::HowHeardPresenter
    include Optimadmin::PresenterMethods

    presents :how_heard
    delegate :id, :title, to: :how_heard
  end
end
