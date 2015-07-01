class CreateEventCategories < ActiveRecord::Migration
  def change
    create_table :event_categories do |t|
      t.integer :parent_id
      t.string :name, null: false
      t.boolean :has_tables
      t.boolean :food_event
      t.boolean :bookable, default: true
      t.string :suggested_url
      t.string :slug
      t.integer :position

      t.timestamps null: false
    end
  end
end
