require "rails_helper"

describe Optimadmin::IndustriesController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when industry is valid" do
      it "redirects to index on normal save" do
        industry = stub_valid_industry

        post :create, commit: "Save", industry: industry.attributes

        expect(response).to redirect_to(industries_path)
        expect(flash[:notice]).to eq("Industry was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        industry = stub_valid_industry

        post :create, commit: "Save and continue editing", industry: industry.attributes

        expect(response).to redirect_to(edit_industry_path(industry))
        expect(flash[:notice]).to eq("Industry was successfully created.")
      end
    end

    context "when industry is invalid" do
      it "renders the edit template" do
        industry = stub_invalid_industry

        post :create, commit: "Save", industry: industry.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when industry is valid" do
      it "redirects to index on normal save" do
        industry = stub_valid_industry

        patch :update, id: industry.id, commit: "Save", industry: industry.attributes

        expect(response).to redirect_to(industries_path)
        expect(flash[:notice]).to eq("Industry was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        industry = stub_valid_industry

        patch :update, id: industry.id, commit: "Save and continue editing", industry: industry.attributes

        expect(response).to redirect_to(edit_industry_path(industry))
        expect(flash[:notice]).to eq("Industry was successfully updated.")
      end
    end

    context "when industry is invalid" do
      it "renders the edit template" do
        industry = stub_invalid_industry

        patch :update, id: industry.id, commit: "Save", industry: industry.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  def stub_valid_industry
    industry = build_stubbed(:industry)
    allow(Industry).to receive(:new).and_return(industry)
    allow(industry).to receive(:save).and_return(true)
    allow(Industry).to receive(:find).and_return(industry)
    allow(industry).to receive(:update).and_return(true)
    industry
  end

  def stub_invalid_industry
    industry = build_stubbed(:industry)
    allow(Industry).to receive(:new).and_return(industry)
    allow(industry).to receive(:save).and_return(false)
    allow(Industry).to receive(:find).and_return(industry)
    allow(industry).to receive(:update).and_return(false)
    industry
  end
end

