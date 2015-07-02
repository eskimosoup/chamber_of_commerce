# This migration comes from optimadmin (originally 20150423094932)
class CreateOptimadminImages < ActiveRecord::Migration
  def change
    create_table :optimadmin_images do |t|
      t.string :name, null: false
      t.string :image, null: false
      t.string :module_name
      t.integer :module_id

      t.timestamps null: false
    end
  end
end
