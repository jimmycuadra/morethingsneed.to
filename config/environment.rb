if File.exists?('/home/jimmycua')
  ENV["GEM_HOME"]="/home/jimmycua/ruby/gems"
  ENV["GEM_PATH"]="/home/jimmycua/ruby/gems:/usr/lib/ruby/gems/1.8"
end

# Load the rails application
require File.expand_path('../application', __FILE__)
require File.join(File.dirname(__FILE__), '/../lib/ip_maker')

# Initialize the rails application
Morethingsneed::Application.initialize!
