class CreateMembershipsPaymentJoinReasons < ActiveRecord::Migration
  def change
    create_table :memberships_payment_join_reasons do |t|
      t.belongs_to :memberships_payment, index: true, foreign_key: true, index: { name: 'index_memberships_join_reasons_on_memberships_payment_id' }
      t.belongs_to :memberships_join_reason, index: true, foreign_key: true, index: { name: 'index_memberships_join_reasons_on_memberships_join_reason_id' }

      t.timestamps null: false
    end
  end
end
