class SetMemberLoginsToActive < ActiveRecord::Migration
  def change
    change_column :member_logins, :active, :boolean, :default => true
  end
end
