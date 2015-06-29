class Page < ActiveRecord::Base
  mount_uploader :image, PageUploader
end
