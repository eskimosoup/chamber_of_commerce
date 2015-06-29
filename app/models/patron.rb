class Patron < ActiveRecord::Base
  mount_uploader :image, PatronUploader
end
