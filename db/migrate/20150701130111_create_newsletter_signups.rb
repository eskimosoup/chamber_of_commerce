class CreateNewsletterSignups < ActiveRecord::Migration
  def change
    create_table :newsletter_signups do |t|
      t.string :email_address

      t.timestamps null: false
    end
  end
end
