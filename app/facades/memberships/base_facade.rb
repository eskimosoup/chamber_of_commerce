module Memberships
  class BaseFacade
    def packages
      @packages = ::Memberships::Package.displayed.ordered
    end

    def packages?
      packages.present?
    end

    #
    # Sidebar menu items for module page
    #
    # @param [string] module_page
    # @param [string] menu_name
    #
    # @return [hash, nil]
    #
    def sidebar_menu?(module_page:, menu_name: 'header')
      sidebar_menu(module_page: module_page, menu_name: menu_name).present?
    end

    #
    # Sidebar menu items for module page
    #
    # @param [string] module_page
    # @param [string] menu_name
    #
    # @return [hash, nil]
    #
    def sidebar_menu(module_page:, menu_name: 'header')
      return if current_page(module_page).blank?

      ::MenuItem.related_menu_items(current_page(module_page), menu_name)
    end

    private

    #
    # Current page
    #
    # @param [string] module_page
    #
    # @return [array]
    #
    # @example in controller method
    #   global_facade.current_page('Articles 2')
    #
    # @example before_action
    #   before_action { |x| x.global_facade.current_page('Articles 2') }
    #
    def current_page(module_page)
      Optimadmin::ModulePage.find_by(name: module_page)
    end
  end
end
