# This migration comes from optimadmin (originally 20150414115839)
class CreateOptimadminAdministrators < ActiveRecord::Migration
  def change
    create_table :optimadmin_administrators do |t|
      t.string :username, null: false, index: true
      t.string :email, null: false, index: true
      t.string :role, null: false
      t.string :auth_token, index: true
      t.string :password_digest, null: false
      t.string :password_reset_token
      t.datetime :password_reset_sent_at

      t.timestamps null: false
    end
    Optimadmin::Administrator.create(username: 'optimised', email: 'support@optimised.today',
                                     password: 'optipoipoip', password_confirmation: 'optipoipoip', role: 'master')
  end
end
