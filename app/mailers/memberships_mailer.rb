class MembershipsMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.memberships_mailer.new_enquiry.subject
  #
  def new_enquiry(enquiry)
    @enquiry = enquiry
    mail(to: membership_email, reply_to: @enquiry.email_address)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.memberships_mailer.new_enquiry.subject
  #
  def new_payment(payment)
    @payment = payment
    mail(
      to: @payment.primary_contact_email_address,
      cc: @payment.accounts_contact_email_address,
      bcc: membership_email,
      from: member_offer_email
    )
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.memberships_mailer.new_enquiry.subject
  #
  # MembershipsMailer::new_payment_copy(Memberships::Payment.find(1)).deliver_now
  def new_payment_copy(payment)
    @payment = payment
    @copy = true
    mail(
      to: membership_email,
      subject: t('memberships_mailer.new_payment.subject')
    ) do |format|
      format.html { render('memberships_mailer/new_payment') }
    end
  end
end
