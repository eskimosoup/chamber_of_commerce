class PatronPresenter < BasePresenter
  presents :patron

  def name
    patron.name
  end

  def area
    patron.area
  end

  def highlight?
    patron.highlight?
  end

  def image(item)
    h.image_tag item.image.show, alt: item.name
  end

  def display
      if patron.link.present?
        attributes = { title: patron.name }
        attributes = { rel: 'nofollow' }.merge(attributes) if patron.no_follow?
        h.link_to patron.link, attributes do
          image(patron)
        end
      else
        image(patron)
      end
  end
end
