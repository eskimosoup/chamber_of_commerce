require "rails_helper"

RSpec.describe MembershipsMailer, type: :mailer do
  describe "new_enquiry" do
    let(:mail) { MembershipsMailer.new_enquiry }

    it "renders the headers" do
      expect(mail.subject).to eq("New enquiry")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
