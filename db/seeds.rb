# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
def generate_ip
  rand(255).to_s + '.' + rand(255).to_s + '.' + rand(255).to_s + '.' + rand(255).to_s
end

30.times do |i|
  e = Entry.create(:noun => i, :verb => i, :ip => generate_ip)
  rand(10).times do
    e.comments.create(:comment => 'Comment', :ip => generate_ip)
  end
  rand(20).times do
    e.votes.create(:up_vote => true, :ip => generate_ip)
  end
  rand(20).times do
    e.votes.create(:up_vote => false, :ip => generate_ip)
  end
end