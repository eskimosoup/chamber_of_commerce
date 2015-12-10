require "rails_helper"

describe Optimadmin::PagesController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when page is valid" do
      it "redirects to index on normal save" do
        page = stub_valid_page

        post :create, commit: "Save", page: page.attributes

        expect(response).to redirect_to(pages_path)
        expect(flash[:notice]).to eq("Page was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        page = stub_valid_page

        post :create, commit: "Save and continue editing", page: page.attributes

        expect(response).to redirect_to(edit_page_path(page))
        expect(flash[:notice]).to eq("Page was successfully created.")
      end
    end

    context "when page is invalid" do
      it "renders the edit template" do
        page = stub_invalid_page

        post :create, commit: "Save", page: page.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when page is valid" do
      it "redirects to index on normal save" do
        page = stub_valid_page

        patch :update, id: page.id, commit: "Save", page: page.attributes

        expect(response).to redirect_to(pages_path)
        expect(flash[:notice]).to eq("Page was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        page = stub_valid_page

        patch :update, id: page.id, commit: "Save and continue editing", page: page.attributes

        expect(response).to redirect_to(edit_page_path(page))
        expect(flash[:notice]).to eq("Page was successfully updated.")
      end
    end

    context "when page is invalid" do
      it "renders the edit template" do
        page = stub_invalid_page

        patch :update, id: page.id, commit: "Save", page: page.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  def stub_valid_page
    page = build_stubbed(:page)
    allow(Page).to receive(:new).and_return(page)
    allow(page).to receive(:save).and_return(true)
    allow(Page).to receive(:find).and_return(page)
    allow(page).to receive(:update).and_return(true)
    page
  end

  def stub_invalid_page
    page = build_stubbed(:page)
    allow(Page).to receive(:new).and_return(page)
    allow(page).to receive(:save).and_return(false)
    allow(Page).to receive(:find).and_return(page)
    allow(page).to receive(:update).and_return(false)
    page
  end
end

