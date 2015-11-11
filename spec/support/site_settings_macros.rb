module SiteSettingsMacros

  def site_email
    @site_email = begin
      site_setting = Optimadmin::SiteSetting.find_by(key: "Email")
      if site_setting
        site_setting.value
      else
        "support@optimised.today"
      end
    end
  end

  def site_name
    @site_name = begin
      site_setting = Optimadmin::SiteSetting.find_by(key: "Name")
      if site_setting
        site_setting.value
      else
        "Optimised"
      end
    end
  end
end