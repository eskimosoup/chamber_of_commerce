class AddLayoutToEvents < ActiveRecord::Migration
  def change
    add_column :events, :layout, :string
  end
end
