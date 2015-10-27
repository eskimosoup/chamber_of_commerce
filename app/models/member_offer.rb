class MemberOffer < ActiveRecord::Base
  include Filterable

  mount_uploader :image, MemberOfferUploader
  belongs_to :member, counter_cache: true

  validates :title, :summary, :description, :website_link, presence: true
  validates :title, uniqueness: { scope: :member_id }
  validate :end_date_is_after_start_date
  validates :member_id, presence: true

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  scope :verified, -> { where(verified: true) }
  scope :unverified, -> { where("verified <> ? OR verified is NULL", true) }
  #scope :upcoming, -> { where("start_date > ? AND verified = ?", Date.today, true) }
  scope :out_of_date_scope, -> { where("end_date < ? AND verified = ?", Date.today, true) }
  scope :current, -> { where("end_date >= :today OR end_date IS NULL", today: Date.today) }
  scope :member_id, -> (member_id) { joins(:member).where(member_id: member_id) }

  after_save :verify_member

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "cannot be before the start date")
    end
  end

  def verify_member
    return unless verified.present? || member.verified.present?
    member.update_attribute(:verified, true)
    member.save
  end
end
