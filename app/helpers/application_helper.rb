module ApplicationHelper
  def two_tone_title(title)
    size = title.scan(/[\w-]+/).size

    if size > 1
      length = size - 1
      first_words  = title.split(' ')[0..length - 1].join(' ')
      last_word = title.split(' ').last
      "#{first_words} <span class='last-word'>#{last_word}</span>".html_safe
    else
      "#{title}"
    end
  end

  def closure_tree_select(items, &block)
    return closure_tree_select(items){ |i| "#{'-' * i.depth} #{i.name}" } unless block_given?
    result = []
    items.map do |item, sub_items|
      result << [yield(item), item.id]
      #this is a recursive call:
      result += closure_tree_select(sub_items, &block) if sub_items.present?
    end
    result
  end
end
