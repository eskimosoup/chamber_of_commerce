class AddTextToInternalPromotion < ActiveRecord::Migration
  def change
    add_column :internal_promotions, :text, :text
    change_column_null :internal_promotions, :image, true
  end
end
