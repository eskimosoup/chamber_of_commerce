# == Schema Information
#
# Table name: event_offices
#
#  id         :integer          not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe EventOffice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
