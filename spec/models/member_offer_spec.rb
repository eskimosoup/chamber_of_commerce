# == Schema Information
#
# Table name: member_offers
#
#  id           :integer          not null, primary key
#  description  :text
#  end_date     :date
#  image        :string
#  slug         :string
#  start_date   :date
#  summary      :text             not null
#  title        :string           not null
#  verified     :boolean
#  website_link :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  member_id    :integer
#
# Indexes
#
#  index_member_offers_on_member_id  (member_id)
#
# Foreign Keys
#
#  fk_rails_...  (member_id => members.id)
#
require 'rails_helper'

RSpec.describe MemberOffer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
