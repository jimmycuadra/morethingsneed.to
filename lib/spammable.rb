module Spammable
  def is_spam?
    @is_spam ||= self.spam
  end
  
  def toggle_spam
    self.update_attribute :spam, !is_spam?
  end
end
