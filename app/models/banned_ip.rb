class BannedIp < ActiveRecord::Base
  # validations

  validates_format_of :ip, :with => /\A(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\z/, :message => 'must be a valid IP'

  # callbacks

  after_create  :toggle_spammable
  after_destroy :toggle_spammable

  # methods

  def self.is_banned?(ip)
    find_by_ip(ip)
  end

  def self.toggle_ban(ip)
    if banned_record = (is_banned? ip)
      destroy banned_record
    else
      banned_ip = new
      banned_ip.ip = ip
      banned_ip.save
    end
  end

  private

  def toggle_spammable
    comments = Comment.where(ip: ip )
    entries = Entry.where(ip: ip )

    comments.each do |c|
      c.toggle_spam
    end unless comments.empty?

    entries.each do |e|
      e.toggle_spam
    end unless entries.empty?

    Entry.all.each do |e|
      e.recalculate_comment_count
    end
  end
end
