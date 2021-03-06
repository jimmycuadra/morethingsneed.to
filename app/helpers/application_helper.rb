module ApplicationHelper
  def title(title)
    content_for :title do
      title + ' | '
    end
  end
  
  def description(description)
    content_for :description do
      description
    end
  end
  
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
  
  def link_to_with_current(text, link, condition, *args)
    options = args.first || {}
    options[:class] = condition ? 'current' : nil
    link_to text, link, options
  end
  
  def escape_for_json(str)
    if str
      str.gsub(/"/, '\"').gsub(/\n/, '\n').gsub(/\t/, '  ')
    else
      ''
    end
  end
end
