source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '~> 5.0.7.2'
gem 'rack', '>= 2.0.6'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.12.2'
gem 'redis'
gem 'rack-timeout'
gem 'resque', '~> 1.26.0'
gem 'resque-scheduler'
gem 'sinatra', github: 'sinatra' # added for resque web ui
gem 'loofah', '>= 2.3.1'
gem "actionview", ">= 5.0.7.2"

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'haml-rails'
gem 'font-awesome-sass'
gem 'config'
gem 'attr_encrypted', '~> 3.0.0'
gem 'faraday'
gem 'autoprefixer-rails'
gem 'marionette-rails'
gem 'rails-backbone'
gem 'handlebars_assets'
gem 'maxminddb'

gem 'draper', '3.0.0.pre1'
gem 'devise'
gem 'bcrypt'
gem 'newrelic_rpm'
gem 'geocoder'
gem 'airbrake', '~> 5.6'

gem 'nokogiri', '~> 1.10.8'
gem 'rubyzip', '>= 1.3.0'
gem 'yard', '~> 0.9.20'

group :production do
  gem 'rack-force_domain'
  gem 'rails_12factor'
  gem 'rack-cors', '>= 1.0.4'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'rspec-example_steps'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'annotate'
  gem 'launchy'
  gem 'pry'
  gem 'pry-stack_explorer'
  gem 'pry-rescue'
  gem 'pry-doc'
end

group :development do
  gem 'foreman'
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
end

group :test do
  gem 'capybara',            '2.5.0'
  gem 'capybara-webkit',     '1.7.1'
  gem 'capybara-email',      '2.4.0'
  gem 'selenium-webdriver',  '2.44.0'
  gem 'shoulda-matchers',    '2.8.0'
  gem 'headless', '2.2.0'
  gem 'database_cleaner',   '1.0.1'
  gem 'webmock', '1.20.4'
  gem 'capybara-feature_helpers', '0.0.2'
  gem 'simplecov', require: false
  gem 'rspec-its'
end
