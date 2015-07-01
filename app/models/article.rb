class Article < ActiveRecord::Base
  belongs_to :category
  mount_uploader :image, ArticleUploader
end
