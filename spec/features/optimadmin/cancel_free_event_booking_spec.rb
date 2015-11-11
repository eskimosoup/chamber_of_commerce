require "rails_helper"

RSpec.feature "cancel a free event booking", type: :feature do
  let!(:event) { create(:event) }
  let!(:agenda) { create(:event_agenda, event: event, price: 0.0) }
  let!(:event_booking) { create(:event_booking, event: event, paid: true, attendees: build_list(:attendee, 4, event_agendas: [agenda])) }

  it "should allow cancelling of event bookings" do
    login_to_admin_with("optimised", "optipoipoip")

    click_link "Events"
    click_link "1 booking"
    click_link "event-booking-#{ event_booking.id }"
    click_button "Cancel"
    expect(current_path).to eq(optimadmin.event_event_bookings_path(event))
    expect(page).to have_content "Successfully cancelled booking"
  end
end
