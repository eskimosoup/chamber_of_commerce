class AddFullContentToEvents < ActiveRecord::Migration
  def change
    add_column :events, :fully_booked_content, :text
  end
end
