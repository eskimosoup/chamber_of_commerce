class MemberMailer < ApplicationMailer
  def update_details(site_settings, member, new_details)
    @site_settings = site_settings
    @member = member
    @new_details = new_details
    mail to: @site_settings['Email'], from: @site_settings['Email'], subject: "Member details change - #{@site_settings['Name']}"
  end
end
