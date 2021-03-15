# == Schema Information
#
# Table name: memberships_payment_join_reasons
#
#  id                         :integer          not null, primary key
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  memberships_join_reason_id :integer
#  memberships_payment_id     :integer
#
# Indexes
#
#  index_memberships_join_reasons_on_memberships_join_reason_id  (memberships_join_reason_id)
#  index_memberships_join_reasons_on_memberships_payment_id      (memberships_payment_id)
#
# Foreign Keys
#
#  fk_rails_...  (memberships_join_reason_id => memberships_join_reasons.id)
#  fk_rails_...  (memberships_payment_id => memberships_payments.id)
#
module Memberships
  class PaymentJoinReason < ActiveRecord::Base
    belongs_to :payment, foreign_key: :memberships_payment_id, class_name: '::Memberships::Payment'
    belongs_to :join_reason, foreign_key: :memberships_join_reason_id, class_name: '::Memberships::JoinReason'
  end
end
