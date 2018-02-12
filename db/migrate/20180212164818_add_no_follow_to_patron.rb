class AddNoFollowToPatron < ActiveRecord::Migration
  def change
    add_column :patrons, :no_follow, :boolean, default: false
  end
end
