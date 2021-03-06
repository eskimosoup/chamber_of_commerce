# == Schema Information
#
# Table name: pages
#
#  id            :integer          not null, primary key
#  content       :text
#  display       :boolean          default(TRUE)
#  image         :string
#  layout        :string
#  page_type     :string
#  slug          :string
#  style         :string
#  suggested_url :string
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Page < ActiveRecord::Base

  include MenuResourceable
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  mount_uploader :image, PageUploader

  scope :admin, -> (current_administrator) { unscoped if current_administrator.present? }

  before_save :store_image, if: Proc.new{|page| page.remote_image_url.blank? }
  # before_save :store_file, if: Proc.new{|page| page.remote_file_url.blank? }

  validates :title, :content, presence: true
  validates :suggested_url, allow_blank: true, uniqueness: { message: 'is not unique, leave this blank to generate automatically' }
  validates :page_type, uniqueness: true, allow_blank: true

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

  def self.layouts
    %w{ application }
  end

  def self.styles
    %w{ basic patrons }
  end

  def self.types
    %w{ members_services patrons international_trade policy_and_representation }
  end

  def store_image
    Optimadmin::Image.store_image(self, image) if image.present? && image_changed?
  end

  # def store_file
  #   Optimadmin::Document.store_file(self, file) if file.present? && file_changed?
  # end
end
