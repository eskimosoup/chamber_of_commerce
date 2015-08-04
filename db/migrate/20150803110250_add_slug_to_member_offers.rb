class AddSlugToMemberOffers < ActiveRecord::Migration
  def change
    add_column :member_offers, :slug, :string, unique: true
  end
end
