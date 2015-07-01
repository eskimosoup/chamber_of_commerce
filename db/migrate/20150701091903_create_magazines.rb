class CreateMagazines < ActiveRecord::Migration
  def change
    create_table :magazines do |t|
      t.string :name, null: false
      t.string :file
      t.date :date
      t.string :image
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
