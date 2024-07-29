# frozen_string_literal: true

source 'https://rubygems.org'

ruby File.read('.ruby-version')

# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.1.0'
gem 'bcrypt', '~> 3.1.7'
gem 'cocoon', '~> 1.2.6'
gem 'cookie_consent', git: 'git@github.com:eskimosoup/cookie_consent.git', branch: :sprockets
gem 'faraday', '0.15.4'
gem 'friendly_id', '~> 5.1.0'
gem 'geocoder'
gem 'ipstack'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails', '~> 4.2.1'
gem 'jquery-slick-rails', '1.5.9.1'
gem 'jquery-ui-rails', '~> 5.0.5'
gem 'optimadmin', git: 'git@github.com:eskimosoup/Optimadmin.git', branch: :master
gem 'pg', '~> 0.19.0'
gem 'rails', '>= 4.2', '< 5.0'
gem 'sassc-rails'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'stripe', '4.21.3'
gem 'therubyracer', platforms: :ruby
gem 'tinymce-rails', '4.8.2'
gem 'uglifier', '>= 1.3.0'
gem 'deep_cloneable', '~> 3.2.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '~> 1.4.1'
  gem 'launchy', '~> 2.4.3'
  gem 'poltergeist'
end

group :development do
  gem 'annotate'
  gem 'bullet'
  gem 'flamegraph'
  gem 'guard-rspec', require: false
  gem 'letter_opener'
  gem 'memory_profiler'
  gem 'optimadmin_generators', git: 'git@github.com:eskimosoup/optimadmin_generators.git'
  gem 'quiet_assets', '~> 1.1.0'
  gem 'rack-mini-profiler'
  gem 'stackprof', '~> 0.2.7'
  gem 'thin'
end

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-passenger', require: false
end
