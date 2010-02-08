namespace :db do
  desc 'Load the seed data from db/seeds_[RAILS_ENV].rb'
  task :seed => :environment do
    seed_env_file = File.join(Rails.root, 'db', 'seeds', "#{RAILS_ENV}.rb")
    if File.exist?(seed_env_file)
      puts "Loading db/seeds/#{RAILS_ENV}.rb" 
      load(seed_env_file)
    end
  end
end