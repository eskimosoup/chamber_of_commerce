# == Schema Information
#
# Table name: memberships_how_heards
#
#  id         :integer          not null, primary key
#  display    :boolean          default(TRUE)
#  position   :integer          default(0)
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require_dependency 'memberships'

module Memberships
  class HowHeard < ActiveRecord::Base
    include OptimadminScopes

    scope :ordered, -> { order(:position) }
    scope :displayed, -> { where(display: true) }

    validates :title, presence: true
  end
end
