class AddLayoutToEvent < ActiveRecord::Migration
  def change
    add_column :articles, :layout, :string, default: 'right_image'
  end
end
