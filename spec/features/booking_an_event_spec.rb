require 'rails_helper'

RSpec.feature "Booking An Event", type: :feature do
  describe "Standard Event" do
    let!(:event) { create(:event) }
    let!(:event_category) { create(:event_category) }
    let!(:event_agendas) { create_list(:event_agenda, 4, event: event) }

    it "allows a booking to be made", js: true do
      visit events_path
      expect(current_path).to eq(events_path)
      expect(page).to have_content(event.summary)
      first(:link, event.name).click
      on_current_event_path(event)
      expect(page).to have_content(event.description)
      click_link("book-event")
      expect(current_path).to eq(new_event_event_booking_path(event))

      fill_in "event_booking_name", with: "Joe Bloggs"
      fill_in "event_booking_company_name", with: "Acme Inc."
      fill_in "event_booking_industry", with: "Explosives"
      fill_in "event_booking_nature_of_business", with: "Carton explosives"
      fill_in "event_booking_address", with: "123 Looney Tunes Lane"
      fill_in "event_booking_phone_number", with: "01234 567890"
      fill_in "event_booking_email", with: "wile.e@coyote.co.uk"

      click_link "Add Attendee"
      fill_in "phone_number", with: "01482 666999"
      fill_in "email", with: "test@example.com"

      click_button "Create Booking"

      on_current_event_path(event)
      expect(page).to have_content("Booking Created")
    end
  end

  def on_current_event_path(event)
    expect(current_path).to eq(event_path(event))
  end
end
