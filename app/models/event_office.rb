# == Schema Information
#
# Table name: event_offices
#
#  id         :integer          not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class EventOffice < ActiveRecord::Base
  validates :name, :email, uniqueness: true, presence: true
  validates :email, email: true

  has_many :events
end
