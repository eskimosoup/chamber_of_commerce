class MemberOfferPresenter < BasePresenter
  include Rails.application.routes.url_helpers

  presents :member_offer

  def id
    member_offer.id
  end

  def class_name
    member_offer.class.name.downcase
  end

  def title
    member_offer.title
  end

  def linked_title(options = {})
    h.link_to title, member_offer_path, options
  end

  def linked_truncated_title(options = {}, truncate_length = 136)
    h.link_to (h.truncate(title, length: truncate_length)), member_offer_path, options
  end

  def summary
    h.simple_format member_offer.summary
  end

  def description
    h.raw member_offer.description
  end

  def image
    h.image_tag member_offer.image.show, alt: member_offer.title, class: 'page-image image-right' if member_offer.image?
  end

  def linked_index_image
    h.link_to member_offer_path, title: member_offer.title do
      if member_offer.image?
        h.image_tag member_offer.image.homepage, alt: member_offer.title
      else
        h.image_tag 'placeholders/list-image.jpg', alt: member_offer.title
      end
    end
  end

  def linked_home_image
    h.link_to member_offer_path, title: member_offer.title do
      if member_offer.image?
        h.image_tag member_offer.image.homepage, alt: member_offer.title
      else
        h.image_tag 'placeholders/home-slider.jpg', alt: member_offer.title
      end
    end
  end

  def read_more
    h.link_to 'Read more', member_offer_path, class: 'content-box-ghost-button'
  end

  def information_message
    content = h.content_tag :div, 'This offer has now expired.', class: 'member-offer-information-message' if member_offer.end_date && member_offer.end_date < Date.today && member_offer.verified.present?
    content = h.content_tag :div, 'This offer is upcoming and can only be used after its start date.', class: 'member-offer-information-message' if member_offer.start_date && member_offer.start_date > Date.today && member_offer.verified.present?
    content = h.content_tag :div, 'This offer is not yet verified.', class: 'member-offer-information-message' unless member_offer.verified.present?
    content
  end

  def unverified_message
  end

  def member_offer_validity_class
    ( member_offer.end_date && member_offer.end_date < Date.today ) ? 'member-offer-expired-opacity' : 'member-offer-valid'
  end

  def website(options = {})
    h.link_to 'View website', "http://#{member_offer.website_link}", options
  end

  def date(format = :long)
    h.content_tag :span, class: 'date' do
      if member_offer.start_date.present? && member_offer.start_date > Date.today
        "Starts #{h.l member_offer.start_date, format: format}" if member_offer.start_date.present?
      else
        "Ends #{h.l member_offer.end_date, format: format}" if member_offer.end_date.present?
      end
    end
  end

  def start_date(format = :long)
    return unless member_offer.start_date
    h.content_tag :span, class: 'date' do
      h.l member_offer.start_date, format: format
    end
  end

  def end_date(format = :long)
    return unless member_offer.end_date
    h.content_tag :span, class: 'date' do
      h.l member_offer.end_date, format: format
    end
  end

  def verification_message
    h.content_tag :strong, 'This offer is not yet verified.' unless member_offer.verified.present?
  end

  def member
    member_offer.member
  end

  def member_link(options = {})
    h.link_to member_offer.member.company_name, member_offer.member, options
  end

  def edit_link(current_member)
    #h.content_tag :div, class: 'small-details' do
      h.link_to 'Edit this offer', edit_member_member_offer_path(current_member, member_offer), class: 'edit-button' if current_member == member_offer.member && ( (member_offer.end_date && member_offer.end_date >= Date.today) || member_offer.end_date.blank? )
    #end
  end

  private

  def member_offer_path
    if member_offer.member_id?
      member_member_offer_path(member_offer.member, member_offer)
    else
      members_shared_offer_path(member_offer)
    end
  end
end
