require 'rails_helper'

RSpec.describe AttendeePresenter, type: :presenter do
  let(:attendee) { build(:attendee) }
  subject(:attendee_presenter) { AttendeePresenter.new(object: attendee, view_template: view) }

  describe "attendee accessing model attributes" do
    it "returns the phone number" do
      expect(attendee_presenter.phone_number).to eq(attendee.phone_number)
    end

    it "returns their forename" do
      expect(attendee_presenter.forename).to eq(attendee.forename)
    end

    it "returns their surname" do
      expect(attendee_presenter.surname).to eq(attendee.surname)
    end

    it "returns the email" do
      expect(attendee_presenter.email).to eq(attendee.email)
    end

    it "returns dietary requirements" do
      expect(attendee_presenter.dietary_requirements).to eq(attendee.dietary_requirements)
    end
  end

  describe "manipulating attendee data" do
    it "should return a list of event agendas" do
      event_agendas = content_tag :ul do
        attendee.event_agendas.map do |event_agenda|
          concat(content_tag(:li, event_agenda.name))
        end
      end
      expect(attendee_presenter.event_agendas).to eq(event_agendas)
    end
  end

end