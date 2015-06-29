module ApplicationHelper
  def content_box_area_title(title)
    size = title.scan(/[\w-]+/).size

    if size > 1
      half = (size / 2) - 1
      first_half  = title.split(' ')[0..half].join(' ')
      second_half = title.split(' ')[half + 1..-1].join(' ')
      "#{first_half} <span class='secondary'>#{second_half}</span>".html_safe
    else
      "#{title}"
    end
  end
end
