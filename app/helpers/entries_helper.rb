module EntriesHelper
  def punctuate(verb)
    if verb.match(/[\.?!][")\]]$/)
      verb
    else
      verb + '.'
    end
  end
  
  def vote_counts(entry, type)
    if (type == 'up')
      '(' + pluralize(entry.up_vote_count, 'vote') + ')'
    else
      '(' + pluralize(entry.down_vote_count, 'vote') + ')'
    end
  end
  
  def twitter_link(entry)
    need = entry.needs ? 'needs': 'need'
    message = "More " + h(entry.noun) + ' ' + need + ' to ' + h(punctuate(entry.verb))
    link = ' http://morethingsneed.to/' + entry.id.to_s
    
    truncate_length = TWITTER_LENGTH - link.length
    
    'http://twitter.com/home?status=' + truncate(message, :length => truncate_length) + link
  end
  
  def comment_link(entry)
    legit_comments = entry.comments.find_all_by_spam(false).count
    
    if params[:action] == 'show_spam' or (is_admin and params.key?(:show_spam))
      total_comments = entry.comments.count
      spam_comments = total_comments - legit_comments
      comment_count = pluralize(total_comments, 'thoughtful critique')
      comment_count += ' (' + spam_comments.to_s + ' spam)' if spam_comments > 0
      show_spam = 1
    else
      comment_count = pluralize(legit_comments, 'thoughtful critique')
      show_spam = nil
    end
    
    link_to comment_count, entry_path(entry, :show_spam => show_spam)
  end
  
  def add_comment_link(entry)
    show_spam = (params[:action] == 'show_spam') ? 1 : nil
    link_to 'Add a non-impulsive, well-researched thought', entry_path(entry, :anchor => 'comment', :show_spam => show_spam)
  end
  
  def toggle_spam_link(entry)
    link_text = entry.spam ? 'Mark as legit' : 'Mark as spam'
    link_to link_text, toggle_spam_entry_path(entry), :method => :put
  end
  
  def toggle_comment_spam_link(entry, comment)
    link_text = comment.spam ? 'Mark as legit' : 'Mark as spam'
    link_to link_text, toggle_spam_entry_comment_path(entry, comment), :method => :put
  end
end