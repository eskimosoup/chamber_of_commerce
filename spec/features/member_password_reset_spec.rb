require 'rails_helper'

RSpec.feature "Password Resets", type: :feature do
  describe "password reset page" do
    let(:member_login) { create(:member_login) }

    it "user form" do
      expect_password_reset_form
      within("h1") do
        assert has_content? "Request a New Password"
      end
      assert has_selector? "form"
    end

    it "form submission" do
      expect_password_reset_form
      fill_in 'Username', with: member_login.username
      click_button 'Reset password'
      assert has_content? "Please check your email"
      member_login.generate_reset_token
      expect {
        MemberMailer.password_reset({ name: 'test', email: 'support@optimised.today' }, member_login).deliver_now
      }.to change {
        ActionMailer::Base.deliveries.count
      }.by(1)
    end
  end

  def expect_password_reset_form
    visit new_member_password_reset_url
    expect(current_url).to eq(new_member_password_reset_url)
  end
end
