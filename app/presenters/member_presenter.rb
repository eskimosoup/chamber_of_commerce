class MemberPresenter < BasePresenter
  presents :member

  def company_name
    member.company_name
  end

  def address
    h.raw member.address
  end

  def linked_company_name(options = {})
    h.link_to member.company_name, member, options
  end

  def website(options = {})
    return nil if member.website.blank?
    h.link_to member.website, member.website, options
  end

  def email
    h.mail_to member.email
  end

  def telephone
    member.telephone
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
