class CreateEventLocations < ActiveRecord::Migration
  def change
    create_table :event_locations do |t|
      t.string :address_line_1, null: false
      t.string :address_line_2
      t.string :city, null: false
      t.string :region
      t.string :post_code
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
