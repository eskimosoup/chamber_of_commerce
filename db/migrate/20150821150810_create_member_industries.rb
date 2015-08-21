class CreateMemberIndustries < ActiveRecord::Migration
  def change
    create_table :member_industries do |t|
      t.belongs_to :member, index: true, foreign_key: true
      t.belongs_to :industry, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
