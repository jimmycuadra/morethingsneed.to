source 'http://rubygems.org'

gem 'rails', '3.0.3'
gem 'authlogic', :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'
gem 'will_paginate', "~> 3.0.pre2"
gem 'capistrano'
gem 'capistrano-ext'

gem 'hirb'
gem 'wirble'

group :production do
  gem 'mysql2'
end

group :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
end

group :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'redgreen'
  gem 'autotest-rails'
  gem 'autotest-growl'
  gem 'autotest-fsevent'
end
