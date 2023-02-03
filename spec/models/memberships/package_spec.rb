# == Schema Information
#
# Table name: memberships_packages
#
#  id                  :integer          not null, primary key
#  cost                :decimal(8, 2)    not null
#  display             :boolean          default(TRUE)
#  position            :integer          default(0)
#  special_offer_price :decimal(8, 2)
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'rails_helper'

RSpec.describe Memberships::Package, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
