class InternalPromotionPresenter < BasePresenter
  presents :internal_promotion

  def id
    internal_promotion.id
  end

  def name
    internal_promotion.name
  end

  def text
    internal_promotion.text
  end

  def area
    internal_promotion.area
  end

  def image(item)
    h.image_tag item.image.homepage, alt: item.name
  end

  def leaderboard(area, classes = '')
    #return
    item = internal_promotion.where(area: area).order(created_at: :desc).first
    return unless item.present?

    if item.image.present?
      h.content_tag :div, class: 'row' do
        h.content_tag :div, class: "small-12 medium-10 columns small-centered #{classes}" do
          if item.link.present?
            h.link_to item.link, title: item.name do
              h.image_tag item.image.homepage, alt: item.name
            end
          else
            h.image_tag item.image.homepage, alt: item.name
          end
        end
      end
    else
      h.render 'internal_promotions/internal_promotion', internal_promotion_presenter: item
    end
  end
end
