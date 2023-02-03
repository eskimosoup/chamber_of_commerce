class AddSpecialOfferPriceToMembershipsPackages < ActiveRecord::Migration
  def change
    add_column :memberships_packages, :special_offer_price, :decimal, precision: 8, scale: 2
  end
end
