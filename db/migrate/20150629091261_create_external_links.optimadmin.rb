# This migration comes from optimadmin (originally 20150604101324)
class CreateExternalLinks < ActiveRecord::Migration
  def change
    create_table :optimadmin_external_links do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
