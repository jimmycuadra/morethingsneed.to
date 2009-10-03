# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
30.times do |i|
  e = Entry.create(:noun => i, :verb => i, :ip => '127.0.0.1')
  rand(20).times do
    e.comments.create(:comment => 'Comment', :ip => '127.0.0.1')
  end
  rand(100).times do
    e.votes.create(:up_vote => true, :ip => '127.0.0.1')
  end
  rand(100).times do
    e.votes.create(:up_vote => false, :ip => '127.0.0.1')
  end
end