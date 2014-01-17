source "https://rubygems.org"

ruby "2.0.0"

gem 'rails'
gem 'thin'
gem 'authlogic'
gem 'will_paginate'
gem 'sass-rails'
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
