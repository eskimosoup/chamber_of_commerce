class AddEventBriteLinkToEvents < ActiveRecord::Migration
  def change
    add_column :events, :eventbrite_link, :string
  end
end
