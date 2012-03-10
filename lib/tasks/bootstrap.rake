require "securerandom"

namespace :bootstrap do
  file "config/database.yml" => "config/database.yml.example" do |t|
    cp t.prerequisites.first, t.name
  end

  file ".env" do |t|
    open(t.name, "w") do |f|
      f.puts "SECRET_TOKEN=#{SecureRandom.hex(64)}"
    end
  end
end

desc "Prepare a fresh copy of the repository for development"
task :bootstrap => ["config/database.yml", ".env"] do
  Rake::Task["db:migrate"].invoke
end
