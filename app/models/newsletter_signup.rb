class NewsletterSignup < ActiveRecord::Base
  validates :email_address, presence: true, uniqueness: { message: 'already exists on our mailing list' }
end
