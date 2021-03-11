class CreateMembershipsGroups < ActiveRecord::Migration
  def change
    create_table :memberships_groups do |t|
      t.integer :position, default: 0
      t.string :title
      t.text :summary
      t.text :content
      t.string :image
      t.string :slug, index: true
      t.string :suggested_url
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
