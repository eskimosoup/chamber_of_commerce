require "rails_helper"

describe Optimadmin::MemberOffersController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when member offer is valid" do
      it "redirects to index on normal save" do
        member_offer = stub_valid_member_offer

        post :create, commit: "Save", member_offer: member_offer.attributes

        expect(response).to redirect_to(member_offers_path)
        expect(flash[:notice]).to eq("Member offer was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        member_offer = stub_valid_member_offer

        post :create, commit: "Save and continue editing", member_offer: member_offer.attributes

        expect(response).to redirect_to(edit_member_offer_path(member_offer))
        expect(flash[:notice]).to eq("Member offer was successfully created.")
      end
    end

    context "when member_offer is invalid" do
      it "renders the edit template" do
        member_offer = stub_invalid_member_offer

        post :create, commit: "Save", member_offer: member_offer.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when member offer is valid" do
      it "redirects to index on normal save" do
        member_offer = stub_valid_member_offer

        patch :update, id: member_offer.id, commit: "Save", member_offer: member_offer.attributes

        expect(response).to redirect_to(member_offers_path)
        expect(flash[:notice]).to eq("Member offer was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        member_offer = stub_valid_member_offer

        patch :update, id: member_offer.id, commit: "Save and continue editing", member_offer: member_offer.attributes

        expect(response).to redirect_to(edit_member_offer_path(member_offer))
        expect(flash[:notice]).to eq("Member offer was successfully updated.")
      end
    end

    context "when member_offer is invalid" do
      it "renders the edit template" do
        member_offer = stub_invalid_member_offer

        patch :update, id: member_offer.id, commit: "Save", member_offer: member_offer.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  def stub_valid_member_offer
    member_offer = build_stubbed(:member_offer)
    allow(MemberOffer).to receive(:new).and_return(member_offer)
    allow(member_offer).to receive(:save).and_return(true)
    allow(MemberOffer).to receive(:find).and_return(member_offer)
    allow(member_offer).to receive(:update).and_return(true)
    member_offer
  end

  def stub_invalid_member_offer
    member_offer = build_stubbed(:member_offer)
    allow(MemberOffer).to receive(:new).and_return(member_offer)
    allow(member_offer).to receive(:save).and_return(false)
    allow(MemberOffer).to receive(:find).and_return(member_offer)
    allow(member_offer).to receive(:update).and_return(false)
    member_offer
  end
end

