class CreateMemberOffers < ActiveRecord::Migration
  def change
    create_table :member_offers do |t|
      t.belongs_to :member, index: true, foreign_key: true
      t.string :title, null: false
      t.text :summary, null: false
      t.text :description
      t.string :website_link
      t.string :image
      t.date :start_date
      t.date :end_date
      t.boolean :verified

      t.timestamps null: false
    end
  end
end
