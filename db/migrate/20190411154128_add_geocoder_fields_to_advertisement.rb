class AddGeocoderFieldsToAdvertisement < ActiveRecord::Migration
  def change
    add_column :advertisements, :longitude, :float, index: true
    add_column :advertisements, :latitude, :float, index: true
    add_column :advertisements, :postcode, :string
    add_column :advertisements, :postcode_radius, :decimal, :precision => 16, :scale => 6
  end
end
