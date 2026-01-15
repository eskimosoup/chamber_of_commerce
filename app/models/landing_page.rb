# == Schema Information
#
# Table name: landing_pages
#
#  id            :integer          not null, primary key
#  content       :text
#  display       :boolean          default(TRUE)
#  footer        :text
#  header        :text
#  image         :string
#  layout        :string           default("application")
#  slug          :string
#  style         :string           default("basic")
#  suggested_url :string
#  title         :string           not null
#  video_embed   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_landing_pages_on_slug  (slug)
#
class LandingPage < ActiveRecord::Base

  include OptimadminScopes
  include MenuResourceable
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  mount_uploader :image, PageUploader

  before_save :store_image, if: Proc.new{|page| page.remote_image_url.blank? }

  validates :title, presence: true
  validates :suggested_url, allow_blank: true, uniqueness: { message: 'is not unique, leave this blank to generate automatically' }

  has_many :landing_page_sections, dependent: :destroy

  scope :displayed, -> { where(display: true) }

  STYLES = ['expo']
  LAYOUTS = ['application']

  def slug_candidates
    [
      :suggested_url,
      :title,
      [:suggested_url, :title]
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || suggested_url_changed? || title_changed?
  end

  def route
    "{:controller => '/pages', :action => 'show', :id => '#{self.slug}'}"
  end

  def store_image
    Optimadmin::Image.store_image(self, image) if image.present? && image_changed?
  end
end
