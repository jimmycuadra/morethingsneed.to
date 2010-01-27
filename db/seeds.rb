# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
def random_spam
  rand(5) < 2 ? true : false
end

ipm = IP_Maker.new

1.upto(20) do |i|
  e = Entry.new(:noun => i.to_s, :verb => i.to_s, :spam => random_spam)
  e.ip = ipm.generate
  e.save
  rand(10).times do
    c = e.comments.build(:comment => 'Comment', :spam => random_spam)
    c.ip = ipm.generate
    c.save
  end
  rand(15).times do
    v = e.votes.build(:up_vote => true)
    v.ip = ipm.generate
    v.save
  end
  rand(15).times do
    v = e.votes.build(:up_vote => false)
    v.ip = ipm.generate
    v.save
  end
end

User.create(:username => 'Jimmy', :password => 'asdf', :password_confirmation => 'asdf', :email => 'jimmy@morethingsneed.to', :active => true, :admin => true)
User.create(:username => 'Mike', :password => 'asdf', :password_confirmation => 'asdf', :email => 'mike@morethingsneed.to', :active => true, :admin => true)
User.create(:username => 'Guest', :password => 'asdf', :password_confirmation => 'asdf', :email => 'guest@website.com', :active => true)
