class CreateEventGroups < ActiveRecord::Migration
  def change
    create_table :event_groups do |t|
      t.integer :position, default: 0
      t.string :area
      t.text :summary
      t.text :content
      t.string :title
      t.boolean :display, default: true
      t.string :slug, index: true
      t.string :suggested_url

      t.timestamps null: false
    end
  end
end
