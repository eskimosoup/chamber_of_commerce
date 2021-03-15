class CreateMembershipsPaymentHowHeards < ActiveRecord::Migration
  def change
    create_table :memberships_payment_how_heards do |t|
      t.belongs_to :memberships_payment, index: true, foreign_key: true
      t.belongs_to :memberships_how_heard, index: true, foreign_key: true, index: { name: 'index_memberships_how_heards_on_memberships_how_heard_id' }

      t.timestamps null: false
    end
  end
end
