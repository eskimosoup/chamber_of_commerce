class MenuItemPresenter < BasePresenter
  presents :menu_item
  attr_reader :link, :menu_resource

  def initialize(object:, view_template:, descendants_hash: nil)
    super(object: object, view_template: view_template)
    @link = menu_item.link
    @menu_resource = @link.menu_resource
    @descendants_hash = descendants_hash
  end

  def link_to_webpage
    return nil if destination.nil?
    h.link_to name, destination, title: title_attribute, class: classes
  end

  def classes
    classes = ["menu-link"]
    classes << "active" if active?
    classes.join(' ')
  end

  private

  def active?
    destination_evaluator.active? || active_descendants?
  end

  def descendants_array
    @desendants_array ||= build_descendants_array
  end

  def build_descendants_array
    flatten_nested_hash(@descendants_hash)
  end

  def flatten_nested_hash(menu_items)
    # flat maps flattens by one level, call recursively packaging the values into one item of an array by the splat operator
    menu_items.flat_map{|k, v| [k, *flatten_nested_hash(v)] }
  end

  def descendants_destinations
    descendants_array.map{|x| MenuItemDestinationEvaluator.new(view_template: h, menu_resource: x.link.menu_resource) }
  end

  def active_descendants?
    descendants_destinations.map(&:active?).any?{|x| x == true }
  end

  def name
    menu_item.name
  end

  def title_attribute
    menu_item.title_attribute
  end

  def destination
    destination_evaluator.destination
  end

  def destination_evaluator
    @destination_evaluator ||= MenuItemDestinationEvaluator.new(view_template: h, menu_resource: menu_resource)
  end
end