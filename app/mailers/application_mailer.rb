class ApplicationMailer < ActionMailer::Base
  layout 'mailer'
  default from: Proc.new{ site_email }

  def site_email
    @site_email = begin
      site_setting = Optimadmin::SiteSetting.where(environment: Rails.env).find_by(key: "Email")
      if site_setting
        site_setting.value
      else
        "support@optimised.today"
      end
    end
  end

  def member_offer_email
    @site_email = begin
      site_setting = Optimadmin::SiteSetting.where(environment: Rails.env).find_by(key: "Member Offers Email")
      if site_setting
        site_setting.value
      else
        "support@optimised.today"
      end
    end
  end

  def membership_email
    @site_email = begin
      site_setting = Optimadmin::SiteSetting.where(environment: Rails.env).find_by(key: "Membership Email")
      if site_setting
        site_setting.value
      else
        "support@optimised.today"
      end
    end
  end

  def site_name
    @site_name = begin
      site_setting = Optimadmin::SiteSetting.where(environment: Rails.env).find_by(key: "Name")
      if site_setting
        site_setting.value
      else
        "Optimised"
      end
    end
  end
end
