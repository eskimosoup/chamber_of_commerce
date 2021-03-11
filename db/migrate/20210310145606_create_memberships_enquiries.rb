class CreateMembershipsEnquiries < ActiveRecord::Migration
  def change
    create_table :memberships_enquiries do |t|
      t.string :forename
      t.string :surname
      t.string :telephone
      t.string :email_address
      t.string :company_name
      t.string :postcode
      t.belongs_to :memberships_package, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
