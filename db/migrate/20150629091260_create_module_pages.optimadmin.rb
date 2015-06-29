# This migration comes from optimadmin (originally 20150604101250)
class CreateModulePages < ActiveRecord::Migration
  def change
    create_table :optimadmin_module_pages do |t|
      t.string :name
      t.string :route

      t.timestamps null: false
    end
  end
end
