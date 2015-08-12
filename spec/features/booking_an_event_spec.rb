require 'rails_helper'

RSpec.feature "Booking An Event", type: :feature do
  describe "Standard Event" do
    let!(:event) { create(:event) }
    let!(:event_category) { create(:event_category) }
    let!(:event_agendas) { create_list(:event_agenda, 4, event: event) }

    it "allows a booking to be made", js: true do

      go_to_event_booking_page

      fill_in "event_booking_name", with: "Joe Bloggs"
      fill_in "event_booking_company_name", with: "Acme Inc."
      fill_in "event_booking_industry", with: "Explosives"
      fill_in "event_booking_nature_of_business", with: "Carton explosives"
      fill_in "event_booking_address", with: "123 Looney Tunes Lane"
      fill_in "event_booking_phone_number", with: "01234 567890"
      fill_in "event_booking_email", with: "wile.e@coyote.co.uk"

      click_link "Add Attendee"

      #save_and_open_page
      expect(page).to have_selector("#event-attendees .nested-fields", count: 1)
      within(all("#event-attendees .nested-fields").last) do
        fill_in "Phone number", with: "01482 666999"
        fill_in "Email", with: "test@example.com"
      end

      click_button "Create Booking"

      on_current_event_path
      expect(page).to have_content("Booking Created")
      expect(EventBooking.last.name).to eq("Joe Bloggs")
      expect(EventBooking.last.attendees.count).to eq(1)
    end

    it "will not allow a booking with no attendees" do
      go_to_event_booking_page

      fill_in "event_booking_name", with: "Joe Bloggs"
      fill_in "event_booking_company_name", with: "Acme Inc."
      fill_in "event_booking_industry", with: "Explosives"
      fill_in "event_booking_nature_of_business", with: "Carton explosives"
      fill_in "event_booking_address", with: "123 Looney Tunes Lane"
      fill_in "event_booking_phone_number", with: "01234 567890"
      fill_in "event_booking_email", with: "wile.e@coyote.co.uk"
      click_button "Create Booking"

    end
  end

  def go_to_event_booking_page
    visit events_path
    expect(current_path).to eq(events_path)
    expect(page).to have_content(event.summary)
    first(:link, event.name).click
    on_current_event_path
    expect(page).to have_content(event.description)
    click_link("book-event")
    on_current_event_booking_path
  end

  def on_current_event_booking_path
    expect(current_path).to eq(new_event_event_booking_path(event))
  end

  def on_current_event_path
    expect(current_path).to eq(event_path(event))
  end
end
