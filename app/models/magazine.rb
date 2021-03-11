# == Schema Information
#
# Table name: magazines
#
#  id         :integer          not null, primary key
#  date       :date
#  display    :boolean          default(TRUE)
#  file       :string
#  image      :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Magazine < ActiveRecord::Base
  mount_uploader :image, MagazineUploader
  mount_uploader :file, Optimadmin::DocumentUploader

  validates :name, :file, :date, :image, presence: true
end
