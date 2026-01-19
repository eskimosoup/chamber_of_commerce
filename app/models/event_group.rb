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
class EventGroup < ActiveRecord::Base
  include OptimadminScopes

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  has_many :event_groupings, dependent: :destroy, class_name: '::EventGrouping'
  has_many :event_categories, through: :event_groupings

  validates :title, presence: true

  scope :displayed, -> { where(display: true) }
  scope :ordered, -> { order(:position) }

  mount_uploader :image, EventUploader

  CATEGORIES = [
    'International',
    'Chamber'
  ].sort.freeze
  public_constant :CATEGORIES

  def events
    Event.event_categories_id(event_category_ids)
  end
end
