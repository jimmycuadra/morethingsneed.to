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
  e = Entry.new(:noun => i.to_s, :verb => i.to_s)
  e.ip = ipm.generate
  e.spam = random_spam
  e.save
  rand(10).times do
    c = e.comments.build(:comment => 'Comment')
    c.ip = ipm.generate
    c.spam = random_spam
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

u = User.new(:password => 'asdf', :password_confirmation => 'asdf', :email => 'jimmy@morethingsneed.to')
u.username = 'Jimmy'
u.admin = true
u.active = true
u.save

u = User.new(:password => 'asdf', :password_confirmation => 'asdf', :email => 'mike@morethingsneed.to')
u.username = 'Mike'
u.admin = true
u.active = true
u.save

u = User.new(:password => 'asdf', :password_confirmation => 'asdf', :email => 'guest@website.com')
u.username = 'Guest'
u.active = true
u.save
