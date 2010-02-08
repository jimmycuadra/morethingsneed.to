if File.exists?('/home/jimmycua')
  ENV["GEM_HOME"]="/home/jimmycua/ruby/gems"
  ENV["GEM_PATH"]="/home/jimmycua/ruby/gems:/usr/lib/ruby/gems/1.8"
end

require File.join(File.dirname(__FILE__), 'boot')
require File.join(File.dirname(__FILE__), '/../lib/ip_maker')

Rails::Initializer.run do |config|
  config.gem  "authlogic"
  config.gem 'will_paginate'

  config.action_controller.session = {
    :session_key => APP_CONFIG['session_key'],
    :secret      => APP_CONFIG['session_secret']
  }
  config.time_zone = 'Pacific Time (US & Canada)'
end
