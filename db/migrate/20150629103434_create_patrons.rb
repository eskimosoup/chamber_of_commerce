class CreatePatrons < ActiveRecord::Migration
  def change
    create_table :patrons do |t|
      t.string :name, null: false
      t.string :image, null: false
      t.string :link
      t.boolean :display, default: true
      t.integer :position, default: 0

      t.timestamps null: false
    end
  end
end
