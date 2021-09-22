# == Schema Information
#
# Table name: magazines
#
#  id           :integer          not null, primary key
#  date         :date
#  display      :boolean          default(TRUE)
#  external_url :string
#  file         :string
#  image        :string
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Magazine < ActiveRecord::Base
  mount_uploader :image, MagazineUploader
  mount_uploader :file, Optimadmin::DocumentUploader

  validates :name, :date, :image, presence: true
  validates :file, presence: true, unless: :external_url?
  validates :external_url, presence: true, unless: :file?
end
