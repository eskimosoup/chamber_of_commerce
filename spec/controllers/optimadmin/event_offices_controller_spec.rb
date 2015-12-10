require "rails_helper"

describe Optimadmin::EventOfficesController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when event office is valid" do
      it "redirects to index on normal save" do
        event_office = stub_valid_event_office

        post :create, commit: "Save", event_office: event_office.attributes

        expect(response).to redirect_to(event_offices_path)
        expect(flash[:notice]).to eq("Event office was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        event_office = stub_valid_event_office

        post :create, commit: "Save and continue editing", event_office: event_office.attributes

        expect(response).to redirect_to(edit_event_office_path(event_office))
        expect(flash[:notice]).to eq("Event office was successfully created.")
      end
    end

    context "when event office is invalid" do
      it "renders the edit template" do
        event_office = stub_invalid_event_office

        post :create, commit: "Save", event_office: event_office.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when event office is valid" do
      it "redirects to index on normal save" do
        event_office = stub_valid_event_office

        patch :update, id: event_office.id, commit: "Save", event_office: event_office.attributes

        expect(response).to redirect_to(event_offices_path)
        expect(flash[:notice]).to eq("Event office was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        event_office = stub_valid_event_office

        patch :update, id: event_office.id, commit: "Save and continue editing", event_office: event_office.attributes

        expect(response).to redirect_to(edit_event_office_path(event_office))
        expect(flash[:notice]).to eq("Event office was successfully updated.")
      end
    end

    context "when event office is invalid" do
      it "renders the edit template" do
        event_office = stub_invalid_event_office

        patch :update, id: event_office.id, commit: "Save", event_office: event_office.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  def stub_valid_event_office
    event_office = build_stubbed(:event_office)
    allow(EventOffice).to receive(:new).and_return(event_office)
    allow(event_office).to receive(:save).and_return(true)
    allow(EventOffice).to receive(:find).and_return(event_office)
    allow(event_office).to receive(:update).and_return(true)
    event_office
  end

  def stub_invalid_event_office
    event_office = build_stubbed(:event_office)
    allow(EventOffice).to receive(:new).and_return(event_office)
    allow(event_office).to receive(:save).and_return(false)
    allow(EventOffice).to receive(:find).and_return(event_office)
    allow(event_office).to receive(:update).and_return(false)
    event_office
  end
end

