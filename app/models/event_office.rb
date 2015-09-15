class EventOffice < ActiveRecord::Base
  validates :name, :email, uniqueness: true, presence: true
  validates :email, email: true

  has_many :events
end
