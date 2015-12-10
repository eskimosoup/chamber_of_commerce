require "rails_helper"

describe Optimadmin::PatronsController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when patron is valid" do
      it "redirects to index on normal save" do
        patron = stub_valid_patron

        post :create, commit: "Save", patron: patron.attributes

        expect(response).to redirect_to(patrons_path)
        expect(flash[:notice]).to eq("Patron was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        patron = stub_valid_patron

        post :create, commit: "Save and continue editing", patron: patron.attributes

        expect(response).to redirect_to(edit_patron_path(patron))
        expect(flash[:notice]).to eq("Patron was successfully created.")
      end
    end

    context "when patron is invalid" do
      it "renders the edit template" do
        patron = stub_invalid_patron

        post :create, commit: "Save", patron: patron.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when patron is valid" do
      it "redirects to index on normal save" do
        patron = stub_valid_patron

        patch :update, id: patron.id, commit: "Save", patron: patron.attributes

        expect(response).to redirect_to(patrons_path)
        expect(flash[:notice]).to eq("Patron was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        patron = stub_valid_patron

        patch :update, id: patron.id, commit: "Save and continue editing", patron: patron.attributes

        expect(response).to redirect_to(edit_patron_path(patron))
        expect(flash[:notice]).to eq("Patron was successfully updated.")
      end
    end

    context "when patron is invalid" do
      it "renders the edit template" do
        patron = stub_invalid_patron

        patch :update, id: patron.id, commit: "Save", patron: patron.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  def stub_valid_patron
    patron = build_stubbed(:patron)
    allow(Patron).to receive(:new).and_return(patron)
    allow(patron).to receive(:save).and_return(true)
    allow(Patron).to receive(:find).and_return(patron)
    allow(patron).to receive(:update).and_return(true)
    patron
  end

  def stub_invalid_patron
    patron = build_stubbed(:patron)
    allow(Patron).to receive(:new).and_return(patron)
    allow(patron).to receive(:save).and_return(false)
    allow(Patron).to receive(:find).and_return(patron)
    allow(patron).to receive(:update).and_return(false)
    patron
  end
end

