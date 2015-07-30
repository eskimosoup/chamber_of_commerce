module MenuResourceable
  extend ActiveSupport::Concern

  included do
    has_many :links, class_name: "Optimadmin::Link", as: :menu_resource
    has_many :menu_items, class_name: "Optimadmin::MenuItem", through: :links
  end

  def menu_names
    menu_items.pluck(:menu_name)
  end

  def side_menus
    side_menu_names.map{|menu_name| Optimadmin::Menu.new(name: menu_name) }
  end

  def side_menu_names
    menu_names.reject{|x| %w(header footer).include?(x) }
  end
end