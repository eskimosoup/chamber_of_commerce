# This migration comes from optimadmin (originally 20150508124937)
class CreateSiteSettings < ActiveRecord::Migration
  def change
    create_table 'optimadmin_site_settings', force: true do |t|
      t.string 'key', unique: true
      t.string 'value'
      t.string 'environment'
    end
    Optimadmin::SiteSetting.create(key: 'Name', value: 'optimadmin', environment: 'development')
    Optimadmin::SiteSetting.create(key: 'Email', value: 'support@optimised.today', environment: 'development')
    Optimadmin::SiteSetting.create(key: 'Meta Description', value: 'optimadmin meta description', environment: 'development')
  end
end
