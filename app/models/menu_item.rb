# frozen_string_literal: true

class MenuItem
  def self.related_menu_items(object, menu_name = 'header')
    if root_menu_item?(object, menu_name)
      menu_items = Optimadmin::MenuItem.joins(:link).where(
        optimadmin_links: {
          menu_resource_id: object.id, menu_resource_type: object.class.name
        }
      ).find_by(menu_name: menu_name).link.menu_item.self_and_descendants.hash_tree
    else
      menu_items = Optimadmin::MenuItem.joins(:link).where(
        optimadmin_links: {
          menu_resource_id: object.id, menu_resource_type: object.class.name
        }
      ).find_by(menu_name: menu_name).link.menu_item.parent.self_and_descendants.hash_tree
    end

    menu_items
  rescue NoMethodError
    nil
  end

  def self.root_menu_items(object, menu_name = 'header')
    if root_menu_item?(object, menu_name)
      menu_items = Optimadmin::MenuItem.joins(:link).where(
        optimadmin_links: {
          menu_resource_id: object.id, menu_resource_type: object.class.name
        }
      ).find_by(menu_name: menu_name).link.menu_item.self_and_descendants.hash_tree
    else
      menu_items = Optimadmin::MenuItem.joins(:link).where(
        optimadmin_links: {
          menu_resource_id: object.id, menu_resource_type: object.class.name
        }
      ).find_by(menu_name: menu_name).link.menu_item.root.self_and_descendants.hash_tree
    end

    menu_items
  rescue NoMethodError
    nil
  end

  def self.root_menu_item?(object, menu_name)
    Optimadmin::MenuItem.joins(:link).where(
      optimadmin_links: {
        menu_resource_id: object.id, menu_resource_type: object.class.name
      }
    ).find_by(menu_name: menu_name).link.menu_item.root?
  end

  def self.parent_menu_items(object, menu_name)
    Optimadmin::MenuItem.joins(:link).where(
      optimadmin_links: {
        menu_resource_id: object.id, menu_resource_type: object.class.name
      }
    ).find_by(menu_name: menu_name).link.menu_item.self_and_ancestors
  end
end
