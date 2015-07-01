module Optimadmin
  class BaseCollectionPresenter

    delegate :current_page, :total_pages, :limit_value, to: :collection
    delegate :size, to: :presented_collection

    attr_reader :collection, :presenter, :view_template

    def initialize(collection:, view_template:, presenter:)
      @collection = collection
      @view_template = view_template
      @presenter = presenter
    end

    def presented_collection
      @presented_collection ||= collection.map{|item| present_item(item) }
    end

    def each(&block)
      presented_collection.each(&block)
    end

    protected

    def present_item(item)
      presenter.new(object: item, view_template: view_template)
    end
  end
end