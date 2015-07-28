module Optimadmin
  class BasePresenter

    attr_reader :partial_path
    def initialize(object:, view_template:)
      @object = object
      @view_template = view_template
    end

    def self.presents(name)
      define_method(name) do
        @object
      end
    end

    # https://robots.thoughtbot.com/rendering-collections-in-rails
    def to_partial_path
      @object.to_partial_path
    end

    def edit_image(image)
      h.it_edit_images(image).call(@object)
    end

    def view_link
      h.link_to eye, h.polymorphic_url(@object), class: 'menu-item-control'
    end

    def edit_link
      h.link_to pencil, h.polymorphic_url([:edit, @object]), class: 'menu-item-control'
    end

    def delete_link
      h.link_to trash_can, h.polymorphic_url(@object), method: :delete, data: { confirm: 'Are you sure?' }, class: 'menu-item-control'
    end

    def detail_toggle_link
      h.link_to(chevron_down, "#index-list-#{@object.id}", class: 'toggle-module-list-index helper-link', data: { container: "index-list-#{@object.id}", class: 'hide', return: 'true', this_class: 'octicon-chevron-up octicon-chevron-down' }) # if can?(:read, @object)
    end

    def toggle_link(attribute = :display)
      return nil unless @object.respond_to?(attribute)
      h.link_to((@object.send("#{attribute}?") ? 'Yes' : 'No'), h.toggle_path(model: @object.class.name.demodulize, id: @object.id, toggle: attribute), id: "#{attribute.to_s}-#{@object.id}", class: "helper-link display #{ @object.send("#{attribute}?") ? 'true' : 'false' }", remote: true)
    end

    def show_link

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

    def chevron_down
      h.octicon('chevron-down').html_safe
    end
  end
end
