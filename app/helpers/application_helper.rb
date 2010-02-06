module ApplicationHelper
  def render_error_messages(*objects)
    messages = objects.compact.map { |o| o.errors.full_messages }.flatten
    render :partial => 'partials/error_messages', :object => messages unless messages.empty?
  end
  
  def datetime_written_out(record)
    record.created_at.to_s(:written_out).gsub(/([^\d:])0(\d+)/, '\1\2')
  end
  
  def datetime_simple(record)
    record.created_at.to_s(:simple).gsub(/0?(\d+)\/0?(\d+)/, '\1/\2')
  end
end
