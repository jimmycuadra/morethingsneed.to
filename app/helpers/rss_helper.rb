module RssHelper
  def rss_entry(entry)
    need = entry.needs ? 'needs': 'need'
    'More ' + entry.noun + ' ' + need + ' to ' + punctuate(entry.verb)
  end
  
  def rss_title(entry)
    rss_entry(entry)
  end
  
  def rss_description(entry)
    '<p>' + (entry.user ? entry.user.username : 'Someone') + ' added:</p>' +
    '<p>' + rss_entry(entry) + '</p>' +
    '<p><a href="http://morethingsneed.to/' + entry.id.to_s + '">Read comments and add a comment</a><br />' +
    '<a href="http://morethingsneed.to">Write your own entries</a></p>'
  end
end
