class AdditionalContent < ActiveRecord::Base
  AREAS = [
              'Magazines - Index',
              'Events - Index',
              'Members - Index',
              'Members Area - Sign Up',
              'Members Area - Login',
              'Member Offers - Index',
              'App Banner'
            ]

  validates :area, uniqueness: true
  validates :area, :title, :content, presence: true
end
