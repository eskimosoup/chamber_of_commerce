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
FactoryGirl.define do
  factory :memberships_payment_join_reason, class: 'Memberships::PaymentJoinReason' do
    memberships_payment nil
    memberships_join_reason nil
  end
end
