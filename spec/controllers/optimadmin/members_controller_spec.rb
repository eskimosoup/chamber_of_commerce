require "rails_helper"

describe Optimadmin::MembersController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when member is valid" do
      it "redirects to index on normal save" do
        member = stub_valid_member

        post :create, commit: "Save", member: member.attributes

        expect(response).to redirect_to(members_path)
        expect(flash[:notice]).to eq("Member was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        member = stub_valid_member

        post :create, commit: "Save and continue editing", member: member.attributes

        expect(response).to redirect_to(edit_member_path(member))
        expect(flash[:notice]).to eq("Member was successfully created.")
      end
    end

    context "when member is invalid" do
      it "renders the edit template" do
        member = stub_invalid_member

        post :create, commit: "Save", member: member.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when member is valid" do
      it "redirects to index on normal save" do
        member = stub_valid_member

        patch :update, id: member.id, commit: "Save", member: member.attributes

        expect(response).to redirect_to(members_path)
        expect(flash[:notice]).to eq("Member was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        member = stub_valid_member

        patch :update, id: member.id, commit: "Save and continue editing", member: member.attributes

        expect(response).to redirect_to(edit_member_path(member))
        expect(flash[:notice]).to eq("Member was successfully updated.")
      end
    end

    context "when member is invalid" do
      it "renders the edit template" do
        member = stub_invalid_member

        patch :update, id: member.id, commit: "Save", member: member.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  def stub_valid_member
    member = build_stubbed(:member)
    allow(Member).to receive(:new).and_return(member)
    allow(member).to receive(:save).and_return(true)
    allow(Member).to receive(:find).and_return(member)
    allow(member).to receive(:update).and_return(true)
    member
  end

  def stub_invalid_member
    member = build_stubbed(:member)
    allow(Member).to receive(:new).and_return(member)
    allow(member).to receive(:save).and_return(false)
    allow(Member).to receive(:find).and_return(member)
    allow(member).to receive(:update).and_return(false)
    member
  end
end

