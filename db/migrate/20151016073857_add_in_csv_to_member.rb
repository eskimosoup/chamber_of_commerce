class AddInCsvToMember < ActiveRecord::Migration
  def change
    add_column :members, :in_csv, :boolean, default: true
  end
end
