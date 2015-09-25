require 'rails_helper'

RSpec.feature "Booking An Event", type: :feature do

  before(:each) do
    Capybara.default_max_wait_time = 7
  end

  describe "Standard Event" do
    let!(:event) { create(:event) }
    let!(:event_category) { create(:event_category) }
    let!(:event_agendas) { create_list(:event_agenda, 4, event: event) }

    it "allows a booking to be made", js: true do
      go_to_event_booking_page

      fill_in_booking_fields

      click_link "Add Attendee"

      expect(page).to have_selector("#event-attendees .nested-fields", count: 1)
      within(all("#event-attendees .nested-fields").last) do
        fill_in "Forename", with: "Joe"
        fill_in "Surname", with: "Bloggs"
        fill_in "Phone number", with: "01482 666999"
        fill_in "Email", with: "test@example.com"
        event_agendas.each do |event_agenda|
          check("event-agenda-checkbox-#{ event_agenda.id }")
        end
      end

      click_button "Create Booking"

      within("h1") do
        expect(page).to have_content("Pay for your booking")
      end

      click_button("Pay with Card")

      Capybara.within_frame "stripe_checkout_app" do
        fill_in "card_number", with: "4242424242424242"
        fill_in "cc-exp", with: "#{ (Date.today + 1.year).strftime("%m%y") }"
        fill_in "cc-csc", with: "123"
        click_button "submitButton"
        wait_for_ajax
      end
      expect(page).to have_content("Thank you for your payment")
    end

    it "will not allow a booking with no attendees" do
      go_to_event_booking_page

      fill_in_booking_fields
      click_button "Create Booking"

      expect(page).to have_content "Attendees can't be blank"
    end
  end

  describe "eventbrite event" do
    let!(:event) { create(:event, eventbrite_link: "http://www.google.co.uk/") }
    let!(:event_category) { create(:event_category) }
    let!(:event_agendas) { create_list(:event_agenda, 4, event: event) }

    it "should go to eventbrite link on clicking book" do
      visit events_path
      expect(current_path).to eq(events_path)
      expect(page).to have_content(event.summary)
      first(:link, event.name).click
      on_current_event_path
      expect(page).to have_content(event.description)
      click_link("book-event")
      expect(current_url).to eq(event.eventbrite_link)
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

  def fill_in_booking_fields
    fill_in "event_booking_forename", with: "Joe"
    fill_in "event_booking_surname", with: "Bloggs"
    fill_in "event_booking_company_name", with: "Acme Inc."
    fill_in "event_booking_industry", with: "Explosives"
    fill_in "event_booking_nature_of_business", with: "Carton explosives"
    fill_in "event_booking_address_line_1", with: "123 Looney Tunes Lane"
    fill_in "event_booking_address_line_2", with: "Looney Tunes Street"
    fill_in "event_booking_town", with: "Looney Tunes City"
    fill_in "event_booking_postcode", with: "LT12 3LT"
    fill_in "event_booking_phone_number", with: "01234 567890"
    fill_in "event_booking_email", with: "wile.e@coyote.co.uk"
  end
end

