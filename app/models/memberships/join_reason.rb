# == Schema Information
#
# Table name: memberships_join_reasons
#
#  id         :integer          not null, primary key
#  display    :boolean          default(TRUE)
#  position   :integer          default(0)
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Memberships
  class JoinReason < ActiveRecord::Base
    include OptimadminScopes

    scope :ordered, -> { order(:position) }
    scope :displayed, -> { where(display: true) }

    validates :title, presence: true

    has_many :payment_join_reasons,
             class_name: '::Memberships::PaymentJoinReason',
             foreign_key: :memberships_join_reason_id,
             dependent: :nullify
    has_many :payments, through: :payment_join_reasons
  end
end
