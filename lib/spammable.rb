module Spammable
  def self.included(klass)
    klass.send :validate_on_create, :cannot_be_from_banned_ip
  end
  
  def is_spam?
    @is_spam ||= self.spam
  end
  
  def toggle_spam
    self.update_attribute :spam, !is_spam?
  end
  
  def cannot_be_from_banned_ip
    errors.add_to_base('Your IP has been banned. Now GTFO!') if BannedIp.is_banned? self.ip
  end
end
