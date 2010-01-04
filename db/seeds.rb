# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
ipm = IP_Maker.new

1.upto(30) do |i|
  e = Entry.create(:noun => i.to_s, :verb => i.to_s, :ip => ipm.generate)
  rand(10).times do
    e.comments.create(:comment => 'Comment', :ip => ipm.generate)
  end
  rand(20).times do
    e.votes.create(:up_vote => true, :ip => ipm.generate)
  end
  rand(20).times do
    e.votes.create(:up_vote => false, :ip => ipm.generate)
  end
end

User.create(:username => 'Jimmy', :password => 'asdf', :password_confirmation => 'asdf', :email => 'jimmy@morethingsneed.to', :active => true, :admin => true)
User.create(:username => 'Mike', :password => 'asdf', :password_confirmation => 'asdf', :email => 'mike@morethingsneed.to', :active => true, :admin => true)
User.create(:username => 'Guest', :password => 'asdf', :password_confirmation => 'asdf', :email => 'guest@website.com', :active => true)
