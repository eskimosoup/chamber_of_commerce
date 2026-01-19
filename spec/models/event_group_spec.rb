# == Schema Information
#
# Table name: event_groups
#
#  id            :integer          not null, primary key
#  area          :string
#  content       :text
#  display       :boolean          default(TRUE)
#  position      :integer          default(0)
#  redirect_url  :string
#  slug          :string
#  suggested_url :string
#  summary       :text
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_event_groups_on_slug  (slug)
#
require 'rails_helper'

RSpec.describe EventGroup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
