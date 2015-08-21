class AddFieldsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :fax, :string
    add_column :members, :post_code, :string
    add_column :members, :chamber_db_id, :integer
    add_index :members, :chamber_db_id
  end
end
