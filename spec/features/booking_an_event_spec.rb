require 'rails_helper'

feature "Booking An Event", type: :feature do
  describe "Standard Event" do
    let!(:event) { create(:event) }
    let!(:event_category) { create(:event_category) }
    let!(:event_agendas) { create_list(:event_agenda, 4, event: event) }

    it "allows a booking to be made" do
      visit events_path
      expect(current_url).to eq(events_url)
      expect(page).to have_content(event.summary)
      first(:link, event.name).click
      on_current_event_url(event)
      expect(page).to have_content(event.description)
      click_link("book-event")
      expect(current_url).to eq(new_event_event_booking_url(event))

      fill_in "name", with: "Joe Bloggs"
      fill_in "company_name", with: "Acme Inc."
      fill_in "industry", with: "Explosives"
      fill_in "nature_of_business", with: "Carton explosives"
      fill_in "address", with: "123 Looney Tunes Lane"
      fill_in "phone_number", with: "01234 567890"
      fill_in "email", with: "wile.e@coyote.co.uk"
      click_button "Create Booking"

      on_current_event_url(event)
      expect(page).to have_content("Booking Created")
    end
  end

  def on_current_event_url(event)
    expect(current_url).to eq(event_url(event))
  end
end
