require "rails_helper"

describe Optimadmin::EventsController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when event is valid" do
      it "redirects to index on normal save" do
        event = stub_valid_event

        post :create, commit: "Save", event: { title: "Blah" }

        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq("Event was successfully created.")
      end

      it "redirects to index on save and continue editing" do
        event = stub_valid_event

        post :create, commit: "Save and continue editing", event: { title: "Blah" }

        expect(response).to redirect_to(edit_event_path(event))
        expect(flash[:notice]).to eq("Event was successfully created.")
      end
    end

    context "when event is invalid" do
      it "renders the new template" do
        event = stub_invalid_event

        post :create, commit: "Save", event: { title: "Blah" }

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when event is valid" do
      it "redirects to index on normal save" do
        event = stub_valid_event

        patch :update, id: event.id, commit: "Save", event: { title: "Blah" }

        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq("Event was successfully updated.")
      end

      it "redirects to index on save and continue editing" do
        event = stub_valid_event

        patch :update, id: event.id, commit: "Save and continue editing", event: { title: "Blah" }

        expect(response).to redirect_to(edit_event_path(event))
        expect(flash[:notice]).to eq("Event was successfully updated.")
      end
    end

    context "when event is invalid" do
      it "renders the edit template" do
        event = stub_invalid_event

        patch :update, id: event.id, commit: "Save", event: { title: "Blah" }

        expect(response).to render_template(:edit)
      end
    end
  end

  def stub_valid_event
    event = build_stubbed(:event)
    allow(Event).to receive(:new).and_return(event)
    allow(event).to receive(:save).and_return(true)
    allow(Event).to receive(:find).and_return(event)
    allow(event).to receive(:update).and_return(true)
    event
  end

  def stub_invalid_event
    event = build_stubbed(:event)
    allow(Event).to receive(:new).and_return(event)
    allow(event).to receive(:save).and_return(false)
    allow(Event).to receive(:find).and_return(event)
    allow(event).to receive(:update).and_return(false)
    event
  end
end

