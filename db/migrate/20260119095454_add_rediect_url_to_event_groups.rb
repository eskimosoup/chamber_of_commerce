class AddRediectUrlToEventGroups < ActiveRecord::Migration
  def change
    add_column :event_groups, :redirect_url, :string
  end
end
