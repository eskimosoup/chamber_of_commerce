class AdditionalContent < ActiveRecord::Base
  AREAS = [
              'Magazines - Index',
              'Events - Index'
            ]

  validates :area, uniqueness: true
  validates :area, :title, :content, presence: true
end
