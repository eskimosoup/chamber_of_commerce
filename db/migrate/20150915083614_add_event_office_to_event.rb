class AddEventOfficeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :event_office_id, :integer
    add_index :events, :event_office_id
  end
end
