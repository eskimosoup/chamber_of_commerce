# This migration comes from optimadmin (originally 20180604082053)
class AddTimestampsToSiteSettings < ActiveRecord::Migration
  def up
    add_column :optimadmin_site_settings, :created_at, :datetime, default: nil, null: true
    add_column :optimadmin_site_settings, :updated_at, :datetime, default: nil, null: true

    Optimadmin::SiteSetting.update_all(
      created_at: Time.zone.now,
      updated_at: Time.zone.now
    )

    change_column :optimadmin_site_settings, :created_at, :datetime, null: false
    change_column :optimadmin_site_settings, :updated_at, :datetime, null: false
  end
end
