module ApplicationHelper
  def render_error_messages(*objects)
    messages = objects.compact.map { |o| o.errors.full_messages }.flatten
    render :partial => 'partials/error_messages', :object => messages unless messages.empty?
  end
  
  def print_vote_counts(entry, type)
    if (type == 'up')
      '(' + pluralize(entry.up_vote_count, 'vote') + ')'
    else
      '(' + pluralize(entry.down_vote_count, 'vote') + ')'
    end
  end
end
