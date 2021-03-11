# == Schema Information
#
# Table name: memberships_groups
#
#  id            :integer          not null, primary key
#  content       :text
#  display       :boolean          default(TRUE)
#  image         :string
#  position      :integer          default(0)
#  slug          :string
#  suggested_url :string
#  summary       :text
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_memberships_groups_on_slug  (slug)
#
require 'rails_helper'

RSpec.describe Memberships::Group, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
