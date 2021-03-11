# == Schema Information
#
# Table name: industries
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  chamber_db_id :integer
#
class Industry < ActiveRecord::Base

  has_many :member_industries, dependent: :destroy
  has_many :members, through: :member_industries
  validates :name, presence: true

end
