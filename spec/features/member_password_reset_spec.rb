require 'rails_helper'

RSpec.feature "Password Resets", type: :feature do
  describe "password reset page" do
    let!(:member_login) { create(:member_login) }
    let!(:member) { create(:member, member_login: member_login)}

    it "emails user when requesting password reset" do
      visit new_member_password_reset_url
      expect(current_url).to eq(new_member_password_reset_url)
      within("h1") do
        expect(page).to have_content("Request a New Password")
      end
      expect(page).to have_selector("form")

      fill_in 'Username', with: member_login.username
      click_button 'Reset password'
      expect(current_url).to eq(new_member_password_reset_url)
      expect(page).to have_content("Please check your email")
      expect(last_email.to).to include(member.email)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
