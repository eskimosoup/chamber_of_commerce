module Optimadmin
  class EventBookingsController < Optimadmin::ApplicationController

    before_action :set_event
    before_action :set_event_booking, only: [:show, :refund]

    def index
      respond_to do |format|
        format.html do
          @event_bookings = Optimadmin::BaseCollectionPresenter.new(collection: @event.event_bookings.includes(attendees: :event_agendas).paid_not_refunded.order(created_at: :desc).page(params[:page]).per(params[:per_page] || 15),
                                                                    view_template: view_context, presenter: Optimadmin::EventBookingPresenter)
        end
        format.csv do
          send_data EventAgenda.to_csv(@event.id)
        end
      end
    end

    def unpaid_or_refunded
      @event_bookings = Optimadmin::BaseCollectionPresenter.new(collection: @event.event_bookings.includes(attendees: :event_agendas).unpaid_or_refunded.order(refunded: :desc, created_at: :desc).page(params[:page]).per(params[:per_page] || 15),
                                                                view_template: view_context, presenter: Optimadmin::EventBookingPresenter)
    end

    def show
      @event_booking_presenter = Optimadmin::EventBookingPresenter.new(object: @event_booking, view_template: view_context)
    end

    def refund
      redirect_to event_event_bookings_path(@event, @event_booking), notice: "Booking has already been refunded" if @event_booking.refunded?
      refund = Stripe::Refund.create(params[:refund])
      @event_booking.update_attribute(:refunded, true)
      EventBookingMailer.booking_refunded.deliver_now(@event_booking)
      redirect_to event_event_bookings_path(@event), notice: "Successfully refunded"
    rescue Stripe::InvalidRequestError, Stripe::APIError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      flash[:error] = e.message
      render :show
    end

    def event_agendas
      @agendas = @event.event_bookings.paid_not_refunded.first.event_agendas.includes(attendee_event_agendas: { attendee: :event_booking })
    end

  private

    def set_event
      @event = Event.find(params[:event_id])
      @event_presenter = Optimadmin::EventPresenter.new(object: @event, view_template: view_context)
    end

    def set_event_booking
      @event_booking = @event.event_bookings.find(params[:id])
    end

    def event_booking_params
      params.require(:event_booking).permit(:name, :company_name, :industry, :nature_of_business, :address, :phone_number, :email, :paid, :attendees_count, :refunded)
    end
  end
end
