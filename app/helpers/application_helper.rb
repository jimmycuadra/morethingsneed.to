module ApplicationHelper
  def render_error_messages(*objects)
    messages = objects.compact.map { |o| o.errors.full_messages }.flatten
    render :partial => 'partials/error_messages', :object => messages unless messages.empty?
  end
  
  def print_vote_counts(entry)
    pluralize(entry.up_vote_count, 'thinks', 'think') + ' this needs to happen - ' + pluralize(entry.down_vote_count, 'thinks', 'think') + ' this doesn\'t need to happen'
  end
end
