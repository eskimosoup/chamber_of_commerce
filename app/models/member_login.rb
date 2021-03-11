# == Schema Information
#
# Table name: member_logins
#
#  id                   :integer          not null, primary key
#  active               :boolean          default(TRUE)
#  auth_token           :string
#  contact_name         :string
#  password_digest      :string
#  password_reset_token :string
#  username             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  member_id            :integer
#
# Indexes
#
#  index_member_logins_on_member_id  (member_id)
#
# Foreign Keys
#
#  fk_rails_...  (member_id => members.id)
#
class MemberLogin < ActiveRecord::Base
  belongs_to :member

  has_secure_password

  validates :member, presence: { message: "company can't be blank" }
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
