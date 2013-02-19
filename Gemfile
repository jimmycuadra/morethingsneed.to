source "https://rubygems.org"

gem 'rails'
gem 'thin'
gem 'authlogic'
gem 'will_paginate'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
end

group :production do
  gem 'pg'
  gem 'newrelic_rpm'
end

group :development do
  gem 'foreman'
end

group :development, :test do
  gem 'sqlite3'
end

group :test do
  gem 'turn'
end
