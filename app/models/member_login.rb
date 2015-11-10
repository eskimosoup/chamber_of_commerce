class MemberLogin < ActiveRecord::Base
  belongs_to :member

  has_secure_password

  validates :member, presence: { message: "company can't be blank" },
                     uniqueness: { message: 'company already has a login' }
  validates :username, presence: true, uniqueness: true
  validates :contact_name, presence: true

  def generate_auth_token
    self.auth_token = secure_auth_token
    update_attribute(:auth_token, secure_auth_token)
  end

  def generate_reset_token
    self.password_reset_token = Digest::SHA1.hexdigest([Time.now, rand].join)[0..25]
    update_attribute(:password_reset_token, password_reset_token)
  end

  private

    def secure_auth_token
      SecureRandom.urlsafe_base64
    end
end
