module EventHelper

  def event_agenda_price(price)
    if price.zero?
      "Free"
    else
      number_to_currency(price)
    end
  end

end