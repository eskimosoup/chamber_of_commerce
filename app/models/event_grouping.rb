# == Schema Information
#
# Table name: event_groupings
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  event_category_id :integer
#  event_group_id    :integer
#
# Indexes
#
#  index_event_groupings_on_event_category_id  (event_category_id)
#  index_event_groupings_on_event_group_id     (event_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_category_id => event_categories.id)
#  fk_rails_...  (event_group_id => event_groups.id)
#
class EventGrouping < ActiveRecord::Base
  belongs_to :event_group
  belongs_to :event_category
end
