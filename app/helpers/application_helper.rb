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
end
