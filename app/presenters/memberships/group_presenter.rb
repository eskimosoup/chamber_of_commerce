module Memberships
  class GroupPresenter < BasePresenter
    presents :group
    delegate :image?, to: :group

    #
    # Header
    #
    # @param [symbol] header_level
    # @param [hash] html_options
    #
    # @return [string]
    #
    def header(header_level = :h1, html_options = {})
      h.content_tag(header_level, group.title, html_options) if group.title?
    end

    #
    # Linked text
    #
    # @param [string] text
    # @param [hash] html_options
    #
    # @return [string]
    #
    def linked_text(text = 'View', html_options = {})
      h.link_to(text, h.memberships_group_path(group), html_options) if text.present?
    end

    #
    # Linked block
    #
    # @param [hash] html_options
    #
    # @return [string]
    #
    def linked_block(html_options = {}, &block)
      h.link_to(h.memberships_group_path(group), html_options, &block)
    end

    #
    # Formatted summary
    #
    # @return [string]
    #
    def summary
      h.raw(group.summary)
    end

    #
    # Formatted content
    #
    # @return [string]
    #
    def content
      h.raw(group.content)
    end

    #
    # Image
    #
    # @param [symbol] crop
    # @param [hash] html_options
    #
    # @return [string]
    #
    def image(crop, html_options = {})
      h.image_tag(group.image.public_send(crop).url, html_options) if image?
    end
  end
end
