source :rubygems

gem 'rails', '3.1.1'

gem 'haml'
gem 'jquery-rails'
gem 'omniauth-contrib', git: "https://github.com/intridea/omniauth-contrib"

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'thin'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'foreman'
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'spork', '>= 0.9.0.rc9'
  gem 'guard-spork'
  gem 'guard-process'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'simplecov', :require => false
  gem 'rb-fsevent'
  gem 'ruby_gntp'
end
