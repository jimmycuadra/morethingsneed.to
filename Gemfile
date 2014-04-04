source "https://rubygems.org"

ruby File.read(File.expand_path("../.ruby-version", __FILE__)).chomp

gem 'rails', '4.0.4'
gem 'thin'
gem 'authlogic'
gem 'will_paginate'
gem 'sass-rails', '4.0.2' # https://github.com/sstephenson/sprockets/issues/540
gem 'uglifier'
gem 'jquery-rails'
gem 'active_model_serializers'

group :production do
  gem 'pg'
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end

group :development do
  gem 'foreman'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'pry'
end

group :test do
  gem 'turn', require: false
  gem 'simplecov'
  gem 'factory_girl_rails'
end
