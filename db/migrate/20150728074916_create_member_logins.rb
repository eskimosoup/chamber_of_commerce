class CreateMemberLogins < ActiveRecord::Migration
  def change
    create_table :member_logins do |t|
      t.belongs_to :member, index: true, foreign_key: true
      t.string :username
      t.string :password_digest
      t.string :auth_token
      t.string :password_reset_token
      t.boolean :active

      t.timestamps null: false
    end
  end
end
