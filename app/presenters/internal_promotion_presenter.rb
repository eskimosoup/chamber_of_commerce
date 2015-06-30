class InternalPromotionPresenter < BasePresenter
  presents :internal_promotion

  def id
    internal_promotion.id
  end

  def name
    internal_promotion.name
  end

  def area
    internal_promotion.area
  end

  def image(item)
    h.image_tag item.image.homepage, alt: item.name
  end

  def leaderboard(area, classes = '')
    item = internal_promotion.where(area: area).order(created_at: :desc).first
    return unless item.present?

    h.content_tag :div, class: 'row' do
      h.content_tag :div, class: "small-10 columns small-centered #{classes}" do
        if item.link.present?
          h.link_to item.link, title: item.name do
            image(item)
          end
        else
          image(item)
        end
      end
    end
  end
end
