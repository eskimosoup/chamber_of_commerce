require 'rails_helper'

RSpec.describe MemberIndustry, type: :model do
  describe "associations", :association do
    it { should belong_to(:member) }
    it { should belong_to(:industry) }
  end
end
