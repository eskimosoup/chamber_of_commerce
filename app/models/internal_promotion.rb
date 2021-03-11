# == Schema Information
#
# Table name: internal_promotions
#
#  id         :integer          not null, primary key
#  area       :string           not null
#  display    :boolean          default(TRUE)
#  image      :string
#  link       :string
#  name       :string           not null
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class InternalPromotion < ActiveRecord::Base
  mount_uploader :image, InternalPromotionUploader

  validates :name, :area, presence: true
  validates :text, presence: { message: "is requried if image is blank" }, unless: Proc.new { |a| a.image? }
  validates :image, presence: { message: "is requried if text is blank" }, unless: Proc.new { |a| a.text? }

  AREAS = [
              'Home - Members Area',
              'Home - About the Chamber',
              'Home - We\'re Social'
            ]
end
