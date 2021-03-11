# == Schema Information
#
# Table name: event_categories
#
#  id            :integer          not null, primary key
#  bookable      :boolean          default(TRUE)
#  food_event    :boolean
#  has_tables    :boolean
#  name          :string           not null
#  position      :integer
#  slug          :string
#  suggested_url :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  parent_id     :integer
#
class EventCategory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  has_closure_tree

  validates :name, presence: true
  validates :suggested_url, allow_blank: true, uniqueness: { message: 'is not unique, leave this blank to generate automatically' }

  has_many :event_agendas

  def slug_candidates
    [
      :suggested_url,
      :name,
      [:suggested_url, :name]
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || suggested_url_changed? || name_changed?
  end
end
