class AddLocationNameToEvents < ActiveRecord::Migration
  def change
    add_column :event_locations, :location_name, :string
    add_column :event_locations, :slug, :string
  end
end
