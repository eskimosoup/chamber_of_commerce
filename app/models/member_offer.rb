class MemberOffer < ActiveRecord::Base
  include Filterable

  mount_uploader :image, MemberOfferUploader
  belongs_to :member, counter_cache: true

  validates :title, :summary, :description, :website_link, presence: true
  validates :title, uniqueness: { scope: :member_id }
  validate :end_date_is_after_start_date
  # validates :member_id, presence: true

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  scope :left_join_members, -> { joins('LEFT JOIN "members" ON "members"."id" = "member_offers"."member_id" AND "members"."in_csv" = true') }
  scope :verified, -> { joins('LEFT JOIN "members" ON "members"."id" = "member_offers"."member_id" AND "members"."in_csv" = true').where("(member_offers.verified = :truth AND members.in_csv = :truth) OR member_id IS NULL", truth: true) }
  scope :unverified, -> { where("verified <> ? OR verified is NULL", true) }
  #scope :upcoming, -> { where("start_date > ? AND verified = ?", Date.today, true) }
  scope :out_of_date_scope, -> { where("end_date < ? AND verified = ?", Date.today, true) }
  scope :current, -> { where("(start_date <= :today OR start_date IS NULL) AND (end_date >= :today OR end_date IS NULL)", today: Date.today).order("(member_id IS NULL), member_offers.created_at DESC") }
  scope :member_id, -> (member_id) { joins(:member).where(member_id: member_id) }

  after_save :verify_member, if: proc { member.present? }

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
