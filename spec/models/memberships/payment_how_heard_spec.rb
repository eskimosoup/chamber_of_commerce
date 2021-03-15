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
require 'rails_helper'

RSpec.describe Memberships::PaymentHowHeard, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
