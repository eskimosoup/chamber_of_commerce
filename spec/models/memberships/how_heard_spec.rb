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
require 'rails_helper'

RSpec.describe Memberships::HowHeard, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
