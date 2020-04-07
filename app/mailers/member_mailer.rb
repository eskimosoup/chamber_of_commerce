class MemberMailer < ApplicationMailer
  def update_details(site_settings, member, new_details)
    @site_settings = site_settings
    @member = member
    @new_details = new_details
    mail to: member_offer_email, from: member_offer_email, subject: "Member details change - #{@site_settings['Name']}"
  end

  def password_reset(site_settings, member)
    @site_settings = site_settings
    @member = member
    mail to: @member.email, from: member_offer_email, subject: "Reset password - #{@site_settings['Name']}"
  end

  def new_member_login(site_settings, member_login)
    @site_settings = site_settings
    @member_login = member_login
    mail to: member_offer_email, from: member_offer_email, subject: "Member login created - #{@site_settings['Name']}"
  end

  def new_member_offer(site_settings, member_offer)
    @site_settings = site_settings
    @member_offer = member_offer
    mail to: member_offer_email, from: member_offer_email, subject: "Member offer created - #{@site_settings['Name']}"
  end

  def edited_member_offer(site_settings, member_offer)
    @site_settings = site_settings
    @member_offer = member_offer
    mail to: member_offer_email, from: member_offer_email, subject: "Member offer edited - #{@site_settings['Name']}"
  end
end
