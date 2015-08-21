class RemoveIndustryFromMembers < ActiveRecord::Migration
  def up
    remove_column :members, :industry
  end

  def down
    add_column :members, :industry, :string
  end
end
