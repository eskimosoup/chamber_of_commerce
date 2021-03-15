# == Schema Information
#
# Table name: memberships_payment_how_heards
#
#  id                       :integer          not null, primary key
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  memberships_how_heard_id :integer
#  memberships_payment_id   :integer
#
# Indexes
#
#  index_memberships_how_heards_on_memberships_how_heard_id        (memberships_how_heard_id)
#  index_memberships_payment_how_heards_on_memberships_payment_id  (memberships_payment_id)
#
# Foreign Keys
#
#  fk_rails_...  (memberships_how_heard_id => memberships_how_heards.id)
#  fk_rails_...  (memberships_payment_id => memberships_payments.id)
#
module Memberships
  class PaymentHowHeard < ActiveRecord::Base
    belongs_to :payment, foreign_key: :memberships_payment_id, class_name: '::Memberships::Payment'
    belongs_to :how_heard, foreign_key: :memberships_how_heard_id, class_name: '::Memberships::HowHeard'
  end
end
