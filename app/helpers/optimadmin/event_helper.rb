module Optimadmin::EventHelper

  def event_agenda_price(price)
    if price.zero?
      "Free"
    else
      number_to_currency(price)
    end
  end

  def vat_total(price)
    price * vat_amount
  end

  def vat_inclusive_price(price)
    price + vat_total(price)
  end

  private

    def vat_amount
      0.2
    end
end
