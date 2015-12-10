require "rails_helper"

describe Optimadmin::MagazinesController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when magazine is valid" do
      it "redirects to index on normal save" do
        magazine = stub_valid_magazine

        post :create, commit: "Save", magazine: magazine.attributes

        expect(response).to redirect_to(magazines_path)
        expect(flash[:notice]).to eq("Magazine was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        magazine = stub_valid_magazine

        post :create, commit: "Save and continue editing", magazine: magazine.attributes

        expect(response).to redirect_to(edit_magazine_path(magazine))
        expect(flash[:notice]).to eq("Magazine was successfully created.")
      end
    end

    context "when magazine is invalid" do
      it "renders the edit template" do
        magazine = stub_invalid_magazine

        post :create, commit: "Save", magazine: magazine.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when magazine is valid" do
      it "redirects to index on normal save" do
        magazine = stub_valid_magazine

        patch :update, id: magazine.id, commit: "Save", magazine: magazine.attributes

        expect(response).to redirect_to(magazines_path)
        expect(flash[:notice]).to eq("Magazine was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        magazine = stub_valid_magazine

        patch :update, id: magazine.id, commit: "Save and continue editing", magazine: magazine.attributes

        expect(response).to redirect_to(edit_magazine_path(magazine))
        expect(flash[:notice]).to eq("Magazine was successfully updated.")
      end
    end

    context "when magazine is invalid" do
      it "renders the edit template" do
        magazine = stub_invalid_magazine

        patch :update, id: magazine.id, commit: "Save", magazine: magazine.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  def stub_valid_magazine
    magazine = build_stubbed(:magazine)
    allow(Magazine).to receive(:new).and_return(magazine)
    allow(magazine).to receive(:save).and_return(true)
    allow(Magazine).to receive(:find).and_return(magazine)
    allow(magazine).to receive(:update).and_return(true)
    magazine
  end

  def stub_invalid_magazine
    magazine = build_stubbed(:magazine)
    allow(Magazine).to receive(:new).and_return(magazine)
    allow(magazine).to receive(:save).and_return(false)
    allow(Magazine).to receive(:find).and_return(magazine)
    allow(magazine).to receive(:update).and_return(false)
    magazine
  end
end

