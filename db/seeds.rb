u = User.new(:password => ENV['JIMMY_PASSWORD'], :password_confirmation => ENV['JIMMY_PASSWORD'], :email => ENV['JIMMY_EMAIL'])
u.username = 'Jimmy'
u.admin = true
u.active = true
u.save

u = User.new(:password => ENV['MIKE_PASSWORD'], :password_confirmation => ENV['MIKE_PASSWORD'], :email => ENV['MIKE_EMAIL'])
u.username = 'Mike'
u.admin = true
u.active = true
u.save

if Rails.env == 'development'
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

  Entry.all.each do |e|
    e.recalculate_comment_count
  end

  u = User.new(:password => 'asdf', :password_confirmation => 'asdf', :email => 'guest@website.com')
  u.username = 'Guest'
  u.active = true
  u.save
end
