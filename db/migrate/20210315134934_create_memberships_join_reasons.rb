class CreateMembershipsJoinReasons < ActiveRecord::Migration
  def change
    remove_column :memberships_payments, :memberships_how_heard_id
    add_column :memberships_enquiries, :message, :text

    create_table :memberships_join_reasons do |t|
      t.integer :position, default: 0
      t.string :title
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
