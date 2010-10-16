namespace :db do
  desc 'Load the seed data from db/seeds_[Rails.env].rb'
  task :seed => :environment do
    seed_env_file = File.join(Rails.root, 'db', 'seeds', "#{Rails.env}.rb")
    if File.exist?(seed_env_file)
      puts "Loading db/seeds/#{Rails.env}.rb" 
      load(seed_env_file)
    end
  end
end
