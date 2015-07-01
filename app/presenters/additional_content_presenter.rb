class AdditionalContentPresenter < BasePresenter
  presents :additional_content

  def title
    h.content_tag :h1 do
      additional_content.title
    end
  end

  def content
    h.raw additional_content.content
  end
end
