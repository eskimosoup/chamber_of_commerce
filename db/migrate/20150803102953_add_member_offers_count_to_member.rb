class AddMemberOffersCountToMember < ActiveRecord::Migration
  def change
    add_column :members, :member_offers_count, :integer, default: 0
  end
end
