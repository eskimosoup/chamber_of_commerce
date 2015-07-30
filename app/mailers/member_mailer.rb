class MemberMailer < ApplicationMailer
  def update_details(site_settings, member, new_details)
    @site_settings = site_settings
    @member = member
    @new_details = new_details
    mail to: @site_settings['Email'], from: @site_settings['Email'], subject: "Member details change - #{@site_settings['Name']}"
  end

  def password_reset(site_settings, member)
    @site_settings = site_settings
    @member = member
    mail to: @member.member.email, from: @site_settings['Email'], subject: "Reset password - #{@site_settings['Name']}"
  end
end
