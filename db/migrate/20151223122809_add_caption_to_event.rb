class AddCaptionToEvent < ActiveRecord::Migration
  def change
    add_column :events, :caption, :string
  end
end
