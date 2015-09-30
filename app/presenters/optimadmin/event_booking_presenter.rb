module Optimadmin
  class EventBookingPresenter < Optimadmin::BasePresenter
    presents :event_booking

    delegate :company_name, :industry, :nature_of_business, :phone_number, :email, :payment_method,
             :attendees_count, :address_line_1, :address_line_2, :town, :postcode, to: :event_booking

    def name
      [event_booking.forename, event_booking.surname].compact.join(" ")
    end

    def address
      return nil unless address_fields.blank?
      h.simple_format(address_fields.compact.join("\n"))
    end

    def price
      h.number_to_currency event_booking.price
    end

    def view_link
      h.link_to eye, h.event_event_booking_path(event_slug, event_booking), class: 'menu-item-control', id: "event-booking-#{ event_booking.id }"
    end

    def paid
      if paid?
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

    def paid?
      event_booking.paid?
    end

    def stripe_charge_id
      event_booking.stripe_charge_id
    end

    def stripe_price
      event_booking.stripe_price
    end

    def refund_reasons
      %w(requested_by_customer duplicate fraudulent).map{|x| [x.titleize, x] }
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

    def address_fields
      [address_line_1, address_line_2, town, postcode].compact.join("\n")
    end

  end
end
