module Optimadmin
  class EventBookingPresenter < Optimadmin::BasePresenter
    presents :event_booking

    delegate :name, :company_name, :industry, :nature_of_business, :phone_number, :email,
             :attendees_count, :address, to: :event_booking

    def price
      h.number_to_currency event_booking.price
    end

    def view_link
      h.link_to eye, h.event_event_booking_path(event_slug, event_booking), class: 'menu-item-control', target: '_blank'
    end

    def paid
      if event_booking.paid?
        "Yes"
      else
        "No"
      end
    end

    def refunded
      if refunded?
        "Yes"
      else
        "No"
      end
    end

    def refunded?
      event_booking.refunded?
    end

    def refund_button
      h.button_to "Refund", h.refund_event_event_booking_path(event_slug, event_booking), class: "refund button"
    end

    def attendees
      @attendees ||= Optimadmin::BaseCollectionPresenter.new(collection: event_booking.attendees, view_template: h, presenter: Optimadmin::AttendeePresenter )
    end

    private

    def event
      @event ||= event_booking.event
    end

    def event_slug
      event.slug
    end

  end
end