class CreateMembershipsPayments < ActiveRecord::Migration
  def change
    create_table :memberships_payments do |t|
      t.string :company_name, null: false
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :county
      t.string :postcode
      t.string :business_activity
      t.integer :number_of_employees
      t.string :website
      t.string :telephone
      t.string :legal_status
      t.date :business_start_date
      t.string :linkedin
      t.string :twitter
      t.string :facebook
      t.string :instagram
      t.string :primary_contact_title
      t.string :primary_contact_forename
      t.string :primary_contact_surname
      t.string :primary_contact_role
      t.string :primary_contact_telephone
      t.string :primary_contact_email_address
      t.string :company_number
      t.string :vat_number
      t.string :accounts_contact_title
      t.string :accounts_contact_forename
      t.string :accounts_contact_surname
      t.string :accounts_contact_role
      t.string :accounts_contact_telephone
      t.string :accounts_contact_email_address
      t.belongs_to :memberships_package, index: true, foreign_key: true
      t.belongs_to :memberships_how_heard, index: true, foreign_key: true
      t.string :memberships_package_title
      t.decimal :memberships_package_cost, scale: 2, precision: 8
      t.decimal :total_paid, scale: 2, precision: 8
      t.boolean :paid, default: false
      t.string :stripe_charge_id
      t.string :stripe_payment_intent_id
      t.string :hashed_id, index: true, unique: true

      t.timestamps null: false
    end
  end
end
