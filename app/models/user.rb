class User < ActiveRecord::Base
  acts_as_authentic
  
  attr_accessible :email, :password, :password_confirmation
  
  def active?
    active
  end
  
  def activate!
    self.active = true
    save
  end
end
