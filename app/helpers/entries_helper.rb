module EntriesHelper
  
  def format_entry(entry)
    'More ' + entry.noun + (entry.needs ? ' needs to ' : ' need to ') + punctuate(entry.verb)
  end
  
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
  
  def twitter_message(entry)
    message = format_entry(entry)
    link = ' http://morethingsneed.to/' + entry.id.to_s
    
    truncate_length = TWITTER_LENGTH - link.length
    truncate(message, :length => truncate_length) + link
  end
  
  def twitter_link(entry)
    'http://twitter.com/home?status=' + twitter_message(entry)
  end
  
  def comment_link(entry)
    if mobile_device?
      comments_text = "thought"
    else 
      comments_text = "thoughtful critique"
    end
    legit_comments = entry.comment_count
    
    if params[:action] == 'show_spam' or (is_admin and params.key?(:show_spam))
      total_comments = entry.comments.count
      spam_comments = total_comments - legit_comments
      comment_count = pluralize(total_comments, comments_text)
      comment_count += ' (' + spam_comments.to_s + ' spam)' if spam_comments > 0
      show_spam = 1
    else
      comment_count = pluralize(legit_comments, comments_text)
      show_spam = nil
    end
    
    link_to comment_count, entry_path(entry, :show_spam => show_spam)
  end
  
  def add_comment_link(entry)
    if mobile_device?
      add_comment_text = "Add a heedful, examined thought"
    else
      add_comment_text = "Add a non-impulsive, well-researched thought"
    end
    
    show_spam = (params[:action] == 'show_spam') ? 1 : nil
    link_to add_comment_text, entry_path(entry, :anchor => 'comment', :show_spam => show_spam)
  end
  
  def toggle_spam_link(entry)
    if mobile_device?
      link_text = entry.spam ? 'Legit!' : 'Spam!'
    else
      link_text = entry.spam ? 'Mark as legit' : 'Mark as spam'
    end
    link_to link_text, toggle_spam_entry_path(entry), :method => :put
  end
  
  def toggle_comment_spam_link(entry, comment)
    link_text = comment.spam ? 'Mark as legit' : 'Mark as spam'
    link_to link_text, toggle_spam_entry_comment_path(entry, comment), :method => :put
  end
end