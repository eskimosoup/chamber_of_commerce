class AdditionalContentPresenter < BasePresenter
  presents :additional_content

  def title(placeholder = '')
    additional_content.present? ? additional_content.title : placeholder
  end

  def content
    additional_content.present? ? (h.raw additional_content.content) : nil
  end
end
