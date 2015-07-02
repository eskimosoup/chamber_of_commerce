class AddModuleNameToOptimadminImages < ActiveRecord::Migration
  def change
    add_column :optimadmin_images, :module_name, :string
  end
end
