class EventLocationPresenter < BasePresenter
  presents :event_location

  def location_name
    h.content_tag :h1 do
      event_location.location_name
    end
  end

  def map
    h.content_tag :div, nil, id: 'map-canvas', data: { latitude: event_location.latitude, longitude: event_location.longitude, title: event_location.location_name }
  end

  def map_window
    h.content_tag :div, class: 'hide', id: 'map-info-window' do
      h.content_tag :div, class: 'map-info-window-popup' do
        address('<br />')
      end
    end
  end

  def address(separator = ', ')
    [event_location.address_line_1,
      event_location.address_line_2,
      event_location.city,
      event_location.region,
      event_location.post_code]
      .compact.reject{|x| x.empty? if x.class == String}.join(separator).html_safe
  end
end
