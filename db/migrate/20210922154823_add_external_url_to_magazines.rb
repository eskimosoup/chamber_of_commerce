class AddExternalUrlToMagazines < ActiveRecord::Migration
  def change
    add_column :magazines, :external_url, :string
  end
end
