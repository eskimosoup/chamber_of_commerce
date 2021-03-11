class CreateMembershipsHowHeards < ActiveRecord::Migration
  def change
    create_table :memberships_how_heards do |t|
      t.integer :position, default: 0
      t.string :title, null: false
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
