class Article < ActiveRecord::Base

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  belongs_to :article_category
  mount_uploader :image, ArticleUploader

  validates :title, :content, :date, :article_category_id, presence: true
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

  def self.published
    joins(:article_category).where(display: true).where("date <= ? AND article_categories.title != ?", Date.today, "Member News").order(date: :desc)
  end
end
