# == Schema Information
#
# Table name: newsletter_signups
#
#  id            :integer          not null, primary key
#  email_address :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class NewsletterSignup < ActiveRecord::Base
  validates :email_address, presence: true, uniqueness: { message: 'already exists on our mailing list' }

  def self.to_csv
    attributes = %w( email_address created_at )
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |sign_up|
        csv << sign_up.attributes.values_at(*attributes)
      end
    end
  end
end
