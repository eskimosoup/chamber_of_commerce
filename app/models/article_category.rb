# == Schema Information
#
# Table name: article_categories
#
#  id             :integer          not null, primary key
#  member_related :boolean          default(FALSE)
#  slug           :string
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_article_categories_on_slug  (slug)
#
class ArticleCategory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  has_many :articles
  validates :title, presence: true, uniqueness: true

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
