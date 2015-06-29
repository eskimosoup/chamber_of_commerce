# This migration comes from optimadmin (originally 20150604122643)
class CreateLinks < ActiveRecord::Migration
  def change
    create_table :optimadmin_links do |t|
      t.string :menu_resource_type
      t.integer :menu_resource_id

      t.timestamps null: false
    end
  end
end
