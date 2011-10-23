guard 'process', name: "More Things Need To", command: "bundle exec foreman start -p 3000" do
  watch("Gemfile.lock")
end

guard 'spork', rspec_env: { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb')
  watch(%r{^spec/support/.+\.rb$})
end

guard 'rspec', cli: "--drb --color", all_after_pass: false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('spec/spec_helper.rb')                        { "spec" }
  watch('spec/factories.rb')                          { "spec" }
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
end

guard 'jasmine-headless-webkit' do
  watch(%r{^app/assets/javascripts/(.*)\.(js|coffee)$}) { |m| "spec/javascripts/#{m[1]}_spec.coffee" }
  watch(%r{^spec/javascripts/(.*)_spec\..*}) { |m| "spec/javascripts/#{m[1]}_spec.coffee" }
end
