require "rails_helper"

RSpec.describe Industry::Import, type: :model do
  describe "building industry members hash" do
    subject(:industry_import) { Industry::Import.new }
    it "should work with one industry" do
      headers = [:id_no, :heading]
      fields = ["6", "industry"]
      row = CSV::Row.new(headers, fields)
      hash = {
        "industry" => ["6"]
      }
      industry_import.add_row_to_industry_members(row)
      expect(industry_import.industry_members).to eq(hash)
    end

    it "should work with two industries" do
      headers = [:id_no, :heading]
      row = CSV::Row.new(headers, ["6", "industry"])
      industry_import.add_row_to_industry_members(row)
      second_row = CSV::Row.new(headers, ["8", "industry 2"])
      industry_import.add_row_to_industry_members(second_row)
      hash = {
          "industry" => ["6"],
          "industry 2" => ["8"]
      }
      expect(industry_import.industry_members).to eq(hash)
    end

    it "should work with multiple ids for one industry" do
      headers = [:id_no, :heading]
      row = CSV::Row.new(headers, ["6", "industry"])
      industry_import.add_row_to_industry_members(row)
      second_row = CSV::Row.new(headers, ["8", "industry 2"])
      industry_import.add_row_to_industry_members(second_row)
      third_row = CSV::Row.new(headers, ["8", "industry"])
      industry_import.add_row_to_industry_members(third_row)
      hash = {
          "industry" => ["6", "8"],
          "industry 2" => ["8"]
      }
      expect(industry_import.industry_members).to eq(hash)
    end
  end
end