require "rails_helper"

describe Optimadmin::EventAgendasController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when event agenda is valid" do
      it "redirects to index on normal save" do
        event_agenda = stub_valid_event_agenda

        post :create, event_id: event_agenda.event_id, commit: "Save", event_agenda: event_agenda.attributes

        expect(response).to redirect_to(event_event_agendas_path(event_agenda.event_id))
        expect(flash[:notice]).to eq("Event agenda was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        event_agenda = stub_valid_event_agenda

        post :create, event_id: event_agenda.event_id, commit: "Save and continue editing", event_agenda: event_agenda.attributes

        expect(response).to redirect_to(edit_event_event_agenda_path(event_agenda.event_id, event_agenda))
        expect(flash[:notice]).to eq("Event agenda was successfully created.")
      end
    end

    context "when event agenda is invalid" do
      it "renders the edit template" do
        event_agenda = stub_invalid_event_agenda

        post :create, event_id: event_agenda.event_id, commit: "Save", event_agenda: event_agenda.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when event agenda is valid" do
      it "redirects to index on normal save" do
        event_agenda = stub_valid_event_agenda

        patch :update, id: event_agenda.id, event_id: event_agenda.event_id, commit: "Save", event_agenda: event_agenda.attributes

        expect(response).to redirect_to(event_event_agendas_path(event_agenda.event_id))
        expect(flash[:notice]).to eq("Event agenda was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        event_agenda = stub_valid_event_agenda

        patch :update, id: event_agenda.id, event_id: event_agenda.event_id, commit: "Save and continue editing", event_agenda: event_agenda.attributes

        expect(response).to redirect_to(edit_event_event_agenda_path(event_agenda.event_id, event_agenda))
        expect(flash[:notice]).to eq("Event agenda was successfully updated.")
      end
    end

    context "when event agenda is invalid" do
      it "renders the edit template" do
        event_agenda = stub_invalid_event_agenda

        patch :update, id: event_agenda.id, event_id: event_agenda.event_id, commit: "Save", event_agenda: event_agenda.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  def stub_valid_event_agenda
    event_agenda = build_stubbed(:event_agenda)
    allow(EventAgenda).to receive(:new).and_return(event_agenda)
    allow(event_agenda).to receive(:save).and_return(true)
    allow(EventAgenda).to receive(:find).and_return(event_agenda)
    allow(Event).to receive(:find).and_return(double("event", id: event_agenda.event_id))
    allow(event_agenda).to receive(:update).and_return(true)
    event_agenda
  end

  def stub_invalid_event_agenda
    event_agenda = build_stubbed(:event_agenda)
    allow(EventAgenda).to receive(:new).and_return(event_agenda)
    allow(event_agenda).to receive(:save).and_return(false)
    allow(EventAgenda).to receive(:find).and_return(event_agenda)
    allow(Event).to receive(:find).and_return(double("event", id: event_agenda.event_id))
    allow(event_agenda).to receive(:update).and_return(false)
    event_agenda
  end
end

