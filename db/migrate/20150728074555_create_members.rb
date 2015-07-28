class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :company_name
      t.string :industry
      t.text :address
      t.string :telephone
      t.string :website
      t.string :email
      t.boolean :verified
      t.text :nature_of_business
      t.integer :member_login_id

      t.timestamps null: false
    end
    add_index :members, :member_login_id
  end
end
