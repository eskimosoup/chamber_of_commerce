# Preview all emails at http://localhost:3000/rails/mailers/memberships_mailer
class MembershipsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/memberships_mailer/new_enquiry
  def new_enquiry
    MembershipsMailer.new_enquiry
  end

end
