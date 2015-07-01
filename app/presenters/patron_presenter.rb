class PatronPresenter < BasePresenter
  presents :patron

  def name
    patron.name
  end

  def area
    patron.area
  end

  def image(item)
    h.image_tag item.image.show, alt: item.name
  end

  def display
    h.content_tag :div do
      if patron.link.present?
        h.link_to patron.link, title: patron.name do
          image(patron)
        end
      else
        image(patron)
      end
    end
  end
end
