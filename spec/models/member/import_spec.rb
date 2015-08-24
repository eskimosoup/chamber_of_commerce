require "rails_helper"

RSpec.describe Member::Import, type: :model do

  describe "making member params hash" do
    it "should import from CSV row and manipulate the appropriate fields" do
      headers = [:company_name, :post_code, :tel_no, :fax_no, :www, :email_no, :nature_of_business, :address_1, :address_2, :address_3,
                 :address_4, :town, :county]
      fields = ["my company", "hu1 1nq", "01482699699", nil, "www.google.co.uk", "example@example.com", "Business", "Salters House",
                "156 High St", nil, nil, "Hull", "Yorkshire"]
      row = CSV::Row.new(headers, fields)
      hash = {
          company_name: "my company",
          post_code: "hu1 1nq",
          telephone: "01482699699",
          fax: nil,
          website: "www.google.co.uk",
          email: "example@example.com",
          nature_of_business: "Business",
          address: "Salters House\n156 High St\nHull\nYorkshire"
      }
      expect(Member::Import.new.make_hash_from_row(row)).to eq(hash)
    end
  end
end