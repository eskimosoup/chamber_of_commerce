class ArticleCategory < ActiveRecord::Base

  has_many :articles
  validates :title, presence: true, uniqueness: true

end
