class MemberOffer < ActiveRecord::Base
  mount_uploader :image, MemberOfferUploader
  belongs_to :member, counter_cache: true

  validates :title, :summary, presence: true
  validates :title, uniqueness: { scope: :member_id }

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  scope :verified, -> { where(verified: true) }
  scope :current, -> { where("(start_date >= :today OR start_date IS NULL) AND (end_date <= :today OR end_date IS NULL)", today: Date.today) }

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
