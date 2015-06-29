module PresenterHelper
  def present(object)
    presenter = object.class.presenter.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def nested_menu_items(menu_items:, depth: 1)
    menu_items.map do |menu_item, sub_menu_items|
      render partial: "menu_items/menu_item",
             locals: { menu_item_presenter: MenuItemPresenter.new(object: menu_item, view_template: self, descendants_hash: sub_menu_items),
                       sub_menu_items: sub_menu_items, depth: depth }
    end.join.html_safe
  end
end
