class AddContactNameToMemberLogin < ActiveRecord::Migration
  def change
    add_column :member_logins, :contact_name, :string
  end
end
