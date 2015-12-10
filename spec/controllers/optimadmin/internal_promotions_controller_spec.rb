require "rails_helper"

describe Optimadmin::InternalPromotionsController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when internal promotion is valid" do
      it "redirects to index on normal save" do
        internal_promotion = stub_valid_internal_promotion

        post :create, commit: "Save", internal_promotion: internal_promotion.attributes

        expect(response).to redirect_to(internal_promotions_path)
        expect(flash[:notice]).to eq("Internal promotion was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        internal_promotion = stub_valid_internal_promotion

        post :create, commit: "Save and continue editing", internal_promotion: internal_promotion.attributes

        expect(response).to redirect_to(edit_internal_promotion_path(internal_promotion))
        expect(flash[:notice]).to eq("Internal promotion was successfully created.")
      end
    end

    context "when internal promotion is invalid" do
      it "renders the edit template" do
        internal_promotion = stub_invalid_internal_promotion

        post :create, commit: "Save", internal_promotion: internal_promotion.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when internal promotion is valid" do
      it "redirects to index on normal save" do
        internal_promotion = stub_valid_internal_promotion

        patch :update, id: internal_promotion.id, commit: "Save", internal_promotion: internal_promotion.attributes

        expect(response).to redirect_to(internal_promotions_path)
        expect(flash[:notice]).to eq("Internal promotion was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        internal_promotion = stub_valid_internal_promotion

        patch :update, id: internal_promotion.id, commit: "Save and continue editing", internal_promotion: internal_promotion.attributes

        expect(response).to redirect_to(edit_internal_promotion_path(internal_promotion))
        expect(flash[:notice]).to eq("Internal promotion was successfully updated.")
      end
    end

    context "when internal promotion is invalid" do
      it "renders the edit template" do
        internal_promotion = stub_invalid_internal_promotion

        patch :update, id: internal_promotion.id, commit: "Save", internal_promotion: internal_promotion.attributes

        expect(response).to render_template(:edit)
      end
    end
  end

  def stub_valid_internal_promotion
    internal_promotion = build_stubbed(:internal_promotion)
    allow(InternalPromotion).to receive(:new).and_return(internal_promotion)
    allow(internal_promotion).to receive(:save).and_return(true)
    allow(InternalPromotion).to receive(:find).and_return(internal_promotion)
    allow(internal_promotion).to receive(:update).and_return(true)
    internal_promotion
  end

  def stub_invalid_internal_promotion
    internal_promotion = build_stubbed(:internal_promotion)
    allow(InternalPromotion).to receive(:new).and_return(internal_promotion)
    allow(internal_promotion).to receive(:save).and_return(false)
    allow(InternalPromotion).to receive(:find).and_return(internal_promotion)
    allow(internal_promotion).to receive(:update).and_return(false)
    internal_promotion
  end
end

