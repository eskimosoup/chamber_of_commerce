class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :name, null: false
      t.string :url
      t.string :image_large, null: false
      t.string :image_medium, null: false
      t.string :image_small, null: false
      t.datetime :publish_at, null: false
      t.datetime :expire_at

      t.timestamps null: false
    end
  end
end
