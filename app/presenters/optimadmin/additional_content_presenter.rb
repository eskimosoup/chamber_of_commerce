module Optimadmin
  class AdditionalContentPresenter < BasePresenter
    presents :additional_content

    def id
      additional_content.id
    end

    def title
      additional_content.title
    end

    def area
      additional_content.area
    end

    def content
      h.raw additional_content.content
    end
  end
end
