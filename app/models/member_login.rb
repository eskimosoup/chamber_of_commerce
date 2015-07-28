class MemberLogin < ActiveRecord::Base
  belongs_to :member

  has_secure_password

  validates :member, presence: { message: "company can't be blank" },
                     uniqueness: { message: 'company already has a login' }
  validates :username, presence: true, uniqueness: true

  def generate_auth_token
    self.auth_token = secure_auth_token
    update_attribute(:auth_token, secure_auth_token)
  end

  private

    def secure_auth_token
      SecureRandom.urlsafe_base64
    end
end
