class BannedIp < ActiveRecord::Base
  # validations
  
  validates_format_of :ip, :with => /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/, :message => 'must be a valid IP'
  
  # methods
  
  def self.is_banned?(ip)
    find_by_ip(ip)
  end
  
  def self.toggle_ban(ip)
    if banned_record = (is_banned? ip)
      destroy banned_record
    else
      create(:ip => ip)
    end
  end  
end
