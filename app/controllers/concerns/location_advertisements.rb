# frozen_string_literal: true

# etag generator for 'fresh_when' and 'stale?' extracted to
# a concern for extra cleanliness
module LocationAdvertisements
  extend ActiveSupport::Concern

  included do
    # etag do
    #   [
    #     SomeModel.all.cache_key, # (only use .cache_key with .all)
    #     generate_etag([Resource.limit(3)])
    #   ]
    # end
  end

  def advertisements
    @advertisements = Advertisement.not_geocoded.displayed + nearby_advertisements
  end

  def geocoded_ip_address
    return unless Rails.env.production?
    @geocoded_ip_address = Rails.cache.fetch(Digest::MD5.hexdigest(request.remote_ip)) do
      Ipstack::API.check
    end
  end

  def nearby_advertisements
    Advertisement.geocoded.displayed.near([geocoded_ip_address['latitude'], geocoded_ip_address['longitude']], :postcode_radius)
  rescue
    []
  end
end
