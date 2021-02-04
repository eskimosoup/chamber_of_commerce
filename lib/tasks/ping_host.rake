# frozen_string_literal: true

namespace :ping_host do
  desc 'Send a HEAD request to preload the application'
  task request: :environment do
    require 'net/http'
    include Rails.application.routes.url_helpers

    uri       = URI(root_url)
    response  = nil
    req_headers = { 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0' }
    http_headers = { read_timeout: 10, use_ssl: (uri.scheme == 'https') }

    Net::HTTP.start(uri.host, uri.port, http_headers) do |http|
      response = http.head('/', req_headers)
    end

    puts [uri, response.code].join(' ')
  end
end
