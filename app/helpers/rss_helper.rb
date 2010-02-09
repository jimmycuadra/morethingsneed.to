module RssHelper
  def rss_entry(entry)
    need = entry.needs ? 'needs': 'need'
    'More ' + entry.noun + ' ' + need + ' to ' + punctuate(entry.verb)
  end
  
  def rss_title(entry)
    rss_entry(entry)
  end
  
  def rss_description(entry)
    rss_entry(entry) + '<br />' +
      '<a href="http://morethingsneed.to/' + entry.id.to_s + '">Read comments</a><br />' +
      '<a href="http://morethingsneed.to">Write your own</a><br /><br />'
  end
end
