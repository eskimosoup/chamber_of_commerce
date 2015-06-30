class CreateInternalPromotions < ActiveRecord::Migration
  def change
    create_table :internal_promotions do |t|
      t.string :name, null: false
      t.string :image, null: false
      t.string :link
      t.string :area, null: false
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
