class Article < ActiveRecord::Base

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  belongs_to :article_category
  mount_uploader :image, ArticleUploader

  scope :published, -> { where("display = ? and date <= ?", true, Date.today) }
  scope :member_news, -> { joins(:article_category).where(article_categories: { member_related: true }) }
  scope :non_member_news, -> { joins(:article_category).where(article_categories: { member_related: false }) }

  validates :title, :content, :date, :article_category, presence: true
  validates :suggested_url, allow_blank: true, uniqueness: { message: 'is not unique, leave this blank to generate automatically' }

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
