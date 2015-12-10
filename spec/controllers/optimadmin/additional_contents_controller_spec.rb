require "rails_helper"

describe Optimadmin::AdditionalContentsController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when additional content is valid" do
      it "redirects to index on normal save" do
        additional_content = stub_valid_additional_content

        post :create, commit: "Save", additional_content: additional_content.attributes

        expect(response).to redirect_to(additional_contents_path)
        expect(flash[:notice]).to eq("Additional content was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        additional_content = stub_valid_additional_content

        post :create, commit: "Save and continue editing", additional_content: additional_content.attributes

        expect(response).to redirect_to(edit_additional_content_path(additional_content))
        expect(flash[:notice]).to eq("Additional content was successfully created.")
      end
    end

    context "when additional content is invalid" do
      it "renders the edit template" do
        additional_content = stub_invalid_additional_content

        post :create, commit: "Save", additional_content: additional_content.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when additional content is valid" do
      it "redirects to index on normal save" do
        additional_content = stub_valid_additional_content

        patch :update, id: additional_content.id, commit: "Save", additional_content: additional_content.attributes

        expect(response).to redirect_to(additional_contents_path)
        expect(flash[:notice]).to eq("Additional content was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        additional_content = stub_valid_additional_content

        patch :update, id: additional_content.id, commit: "Save and continue editing", additional_content: additional_content.attributes

        expect(response).to redirect_to(edit_additional_content_path(additional_content))
        expect(flash[:notice]).to eq("Additional content was successfully updated.")
      end
    end

    context "when additional content is invalid" do
      it "renders the edit template" do
        additional_content = stub_invalid_additional_content

        patch :update, id: additional_content.id, commit: "Save", additional_content: additional_content.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  
  def stub_valid_additional_content
    additional_content = build_stubbed(:additional_content)
    allow(AdditionalContent).to receive(:new).and_return(additional_content)
    allow(additional_content).to receive(:save).and_return(true)
    allow(AdditionalContent).to receive(:find).and_return(additional_content)
    allow(additional_content).to receive(:update).and_return(true)
    additional_content
  end

  def stub_invalid_additional_content
    additional_content = build_stubbed(:additional_content)
    allow(AdditionalContent).to receive(:new).and_return(additional_content)
    allow(additional_content).to receive(:save).and_return(false)
    allow(AdditionalContent).to receive(:find).and_return(additional_content)
    allow(additional_content).to receive(:update).and_return(false)
    additional_content
  end
end

