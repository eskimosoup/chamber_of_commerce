class CreateMembershipsPackages < ActiveRecord::Migration
  def change
    create_table :memberships_packages do |t|
      t.integer :position, default: 0
      t.string :title
      t.decimal :cost, null: false, precision: 8, scale: 2
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
