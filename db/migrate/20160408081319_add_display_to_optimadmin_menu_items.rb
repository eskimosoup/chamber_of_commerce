class AddDisplayToOptimadminMenuItems < ActiveRecord::Migration
  def change
    add_column :optimadmin_menu_items, :display, :boolean, default: true, null: true
  end
end
