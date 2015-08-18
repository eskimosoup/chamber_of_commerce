class ChargesController < ApplicationController

  before_action :set_event_booking

  def new

  end

  def create
    customer = Stripe::Customer.create(
      email: @presented_event_booking.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @presented_event_booking.stripe_price,
      description: "Booking for #{ @presented_event.name }",
      currency: "gbp"
    )
    if @event_booking.update(paid: true, stripe_charge_id: charge.id)
      redirect_to @presented_event, notice: "Thank you for your payment"
    else
      render :new
    end
  rescue Stripe::CardError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    flash[:error] = e.message
    render :new
  end

  private

  def set_event_booking
    @event_booking = EventBooking.includes(attendees: :event_agendas).find(params[:event_booking_id])
    @presented_event_booking = EventBookingPresenter.new(object: @event_booking, view_template: view_context)
    @presented_event = EventPresenter.new(object: @event_booking.event, view_template: view_context)
    @presented_attendees = BaseCollectionPresenter.new(collection: @event_booking.attendees,
                                                       view_template: view_context, presenter: AttendeePresenter)
  end
end
