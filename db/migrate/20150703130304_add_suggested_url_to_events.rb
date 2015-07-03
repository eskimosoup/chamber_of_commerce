class AddSuggestedUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :suggested_url, :string
    add_column :events, :slug, :string
  end
end
