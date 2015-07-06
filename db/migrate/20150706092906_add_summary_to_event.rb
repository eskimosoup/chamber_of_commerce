class AddSummaryToEvent < ActiveRecord::Migration
  def change
    add_column :events, :summary, :text
  end
end
