require "rails_helper"

describe Optimadmin::EventCategoriesController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when event category is valid" do
      it "redirects to index on normal save" do
        event_category = stub_valid_event_category

        post :create, commit: "Save", event_category: event_category.attributes

        expect(response).to redirect_to(event_categories_path)
        expect(flash[:notice]).to eq("Event category was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        event_category = stub_valid_event_category

        post :create, commit: "Save and continue editing", event_category: event_category.attributes

        expect(response).to redirect_to(edit_event_category_path(event_category))
        expect(flash[:notice]).to eq("Event category was successfully created.")
      end
    end

    context "when event category is invalid" do
      it "renders the edit template" do
        event_category = stub_invalid_event_category

        post :create, commit: "Save", event_category: event_category.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when event category is valid" do
      it "redirects to index on normal save" do
        event_category = stub_valid_event_category

        patch :update, id: event_category.id, commit: "Save", event_category: event_category.attributes

        expect(response).to redirect_to(event_categories_path)
        expect(flash[:notice]).to eq("Event category was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        event_category = stub_valid_event_category

        patch :update, id: event_category.id, commit: "Save and continue editing", event_category: event_category.attributes

        expect(response).to redirect_to(edit_event_category_path(event_category))
        expect(flash[:notice]).to eq("Event category was successfully updated.")
      end
    end

    context "when event category is invalid" do
      it "renders the edit template" do
        event_category = stub_invalid_event_category

        patch :update, id: event_category.id, commit: "Save", event_category: event_category.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  def stub_valid_event_category
    event_category = build_stubbed(:event_category)
    allow(EventCategory).to receive(:new).and_return(event_category)
    allow(event_category).to receive(:save).and_return(true)
    allow(EventCategory).to receive(:find).and_return(event_category)
    allow(event_category).to receive(:update).and_return(true)
    event_category
  end

  def stub_invalid_event_category
    event_category = build_stubbed(:event_category)
    allow(EventCategory).to receive(:new).and_return(event_category)
    allow(event_category).to receive(:save).and_return(false)
    allow(EventCategory).to receive(:find).and_return(event_category)
    allow(event_category).to receive(:update).and_return(false)
    event_category
  end
end

