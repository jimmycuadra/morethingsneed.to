class User < ActiveRecord::Base
  acts_as_authentic
  
  attr_accessible :email, :password, :password_confirmation
  
  has_many :entries
  has_many :comments
  
  def active?
    active
  end
  
  def activate!
    self.active = true
    save
  end
  
  def self.per_page
    10
  end
end
