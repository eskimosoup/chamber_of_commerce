# == Schema Information
#
# Table name: articles
#
#  id                  :integer          not null, primary key
#  caption             :string
#  content             :text
#  date                :datetime
#  display             :boolean          default(TRUE)
#  image               :string
#  layout              :string           default("full_image")
#  slug                :string
#  suggested_url       :string
#  summary             :text
#  title               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  article_category_id :integer
#
# Indexes
#
#  index_articles_on_article_category_id  (article_category_id)
#  index_articles_on_slug                 (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (article_category_id => article_categories.id)
#
class Article < ActiveRecord::Base
  include OptimadminScopes

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  belongs_to :article_category
  mount_uploader :image, ArticleUploader

  scope :published, -> { where('display = ? and date <= ?', true, Time.zone.now) }
  scope :member_news, -> { joins(:article_category).where(article_categories: { member_related: true }).published.order(date: :desc) }
  scope :non_member_news, -> { joins(:article_category).where(article_categories: { member_related: false }).published.order(date: :desc) }
  scope :admin, -> (current_administrator) { unscoped if current_administrator.present? }
  scope :scheduled, ->  { where('display = ? and date > ?', true, Time.zone.now) }
  scope :expired, ->  { where('display = ?', false) }

  validates :title, :content, :date, :article_category, presence: true
  validates :suggested_url, allow_blank: true, uniqueness: { message: 'is not unique, leave this blank to generate automatically' }

  def self.layouts
    %w( full_image right_image no_image )
  end

  def slug_candidates
    [
      :suggested_url,
      :title,
      [:suggested_url, :title]
    ]
  end

  def should_generate_new_friendly_id?
    suggested_url_changed? || title_changed?
  end
end
