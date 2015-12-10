require "rails_helper"

describe Optimadmin::EventLocationsController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when event location is valid" do
      it "redirects to index on normal save" do
        event_location = stub_valid_event_location

        post :create, commit: "Save", event_location: event_location.attributes

        expect(response).to redirect_to(event_locations_path)
        expect(flash[:notice]).to eq("Event location was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        event_location = stub_valid_event_location

        post :create, commit: "Save and continue editing", event_location: event_location.attributes

        expect(response).to redirect_to(edit_event_location_path(event_location))
        expect(flash[:notice]).to eq("Event location was successfully created.")
      end
    end

    context "when event location is invalid" do
      it "renders the edit template" do
        event_location = stub_invalid_event_location

        post :create, commit: "Save", event_location: event_location.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when event location is valid" do
      it "redirects to index on normal save" do
        event_location = stub_valid_event_location

        patch :update, id: event_location.id, commit: "Save", event_location: event_location.attributes

        expect(response).to redirect_to(event_locations_path)
        expect(flash[:notice]).to eq("Event location was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        event_location = stub_valid_event_location

        patch :update, id: event_location.id, commit: "Save and continue editing", event_location: event_location.attributes

        expect(response).to redirect_to(edit_event_location_path(event_location))
        expect(flash[:notice]).to eq("Event location was successfully updated.")
      end
    end

    context "when event location is invalid" do
      it "renders the edit template" do
        event_location = stub_invalid_event_location

        patch :update, id: event_location.id, commit: "Save", event_location: event_location.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  def stub_valid_event_location
    event_location = build_stubbed(:event_location)
    allow(EventLocation).to receive(:new).and_return(event_location)
    allow(event_location).to receive(:save).and_return(true)
    allow(EventLocation).to receive(:find).and_return(event_location)
    allow(event_location).to receive(:update).and_return(true)
    event_location
  end

  def stub_invalid_event_location
    event_location = build_stubbed(:event_location)
    allow(EventLocation).to receive(:new).and_return(event_location)
    allow(event_location).to receive(:save).and_return(false)
    allow(EventLocation).to receive(:find).and_return(event_location)
    allow(event_location).to receive(:update).and_return(false)
    event_location
  end
end

