class AddHighlightToPatron < ActiveRecord::Migration
  def change
    add_column :patrons, :highlight, :boolean, default: false
  end
end
