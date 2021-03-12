class AdditionalContentPresenter < BasePresenter
  presents :additional_content

  def title(placeholder = '')
    additional_content.present? ? additional_content.title : placeholder
  end

  def content
    additional_content.present? ? (h.raw additional_content.content) : nil
  end

  def button_text
    h.raw(additional_content.button_text)
  end

  def button_link
    additional_content.button_link
  end

  #
  # Button
  #
  # @param [hash] options
  #
  # @return [string]
  #
  def button(html_options = {})
    h.link_to(button_text, button_link, html_options) if additional_content.button?
  end
end
