module EntriesHelper
  def vote_counts(entry, type)
    if (type == 'up')
      '(' + pluralize(entry.up_vote_count, 'vote') + ')'
    else
      '(' + pluralize(entry.down_vote_count, 'vote') + ')'
    end
  end
  
  def twitter_link(entry)
    need = entry.needs ? 'needs': 'need'
    message = "More " + h(entry.noun) + ' ' + need + ' to ' + h(entry.verb)
    link = ' http://morethingsneed.to/' + entry.id.to_s
    
    truncate_length = TWITTER_LENGTH - link.length
    
    'http://twitter.com/home?status=' + truncate(message, :length => truncate_length) + link
  end
end