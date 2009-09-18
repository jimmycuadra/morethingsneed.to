module ApplicationHelper
  def show_validation_errors(model)
    errors = []
    model.errors.each do |e|
      errors << e[1]
    end
    if errors.blank?
      ''
    else
      content_tag(:div, errors.join('<br />'), :class => 'validation-error')
    end
  end
end
