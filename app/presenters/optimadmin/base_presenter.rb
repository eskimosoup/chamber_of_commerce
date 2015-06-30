module Optimadmin
  class BasePresenter

    def initialize(object:, view_template:)
      @object = object
      @view_template = view_template
    end

    def self.presents(name)
      define_method(name) do
        @object
      end
    end

    private

    def h
      @view_template
    end

    def disabled_delete_link
      h.content_tag :span, class: "disabled" do
        trash_can
      end
    end

    def disabled_show_link
      h.content_tag :span, class: "disabled" do
        eye
      end
    end

    def pencil
      h.octicon('pencil').html_safe
    end

    def trash_can
      h.octicon('trashcan').html_safe
    end

    def eye
      h.octicon('eye').html_safe
    end
  end
end