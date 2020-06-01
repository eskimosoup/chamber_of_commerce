# frozen_string_literal: true

namespace :ping_host do
  desc 'Send a HEAD request to preload the applciation'
  task request: :environment do
    require 'net/http'
    include Rails.application.routes.url_helpers
    uri = URI(root_url)
    Net::HTTP.start(
      uri.host,
      uri.port,
      read_timeout: 10,
      use_ssl: (uri.scheme == 'https')
    ) do |http|
      response = http.head(
        '/',
        'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0'
      )
      puts [uri, response.code].join(' ')
    end
  end
end
