# == Schema Information
#
# Table name: patrons
#
#  id         :integer          not null, primary key
#  display    :boolean          default(TRUE)
#  image      :string           not null
#  link       :string
#  name       :string           not null
#  no_follow  :boolean          default(FALSE)
#  position   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Patron, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:image) }
  end

end
