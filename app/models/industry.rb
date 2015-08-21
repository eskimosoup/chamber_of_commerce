class Industry < ActiveRecord::Base

  has_many :member_industries, dependent: :destroy
  has_many :members, through: :member_industries
  validates :name, presence: true

end
