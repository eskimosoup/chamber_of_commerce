class AddDefaultToDisplayOnEvents < ActiveRecord::Migration
  def change
    change_column :events, :display, :boolean, default: true
  end
end
