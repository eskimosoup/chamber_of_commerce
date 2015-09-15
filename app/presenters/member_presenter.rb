class MemberPresenter < BasePresenter
  presents :member

  def company_name
    member.company_name
  end

  def address
    "#{member.address.gsub("\n", '<br />')} #{member.post_code}".html_safe
  end

  def linked_company_name(options = {})
    h.link_to member.company_name, member, options
  end

  def website(options = {})
    return nil if member.website.blank?
    h.link_to member.website, "http://#{member.website}", options
  end

  def email
    h.mail_to member.email
  end

  def email_present?
    true if member.email.present?
  end

  def telephone
    member.telephone
  end

  def telephone_present?
    true if member.telephone.present?
  end

  def read_more
    h.link_to 'Read more', member, class: 'content-box-ghost-button'
  end

  def member_offers_count
    member.member_offers.verified.current.count
  end

  def member_offers
    member.member_offers.verified.current
  end
end
