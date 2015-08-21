class CreateIndustries < ActiveRecord::Migration
  def change
    create_table :industries do |t|
      t.string :name, null: false
      t.integer :chamber_db_id

      t.timestamps null: false
    end
  end
end
