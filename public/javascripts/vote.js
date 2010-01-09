MTNT.Vote = function($forms) {
  this.$forms = $forms;
  
  this.$forms.submit(this.handleSubmit.bind(this));
}

MTNT.Vote.prototype.handleSubmit = function(e, form) {
  var $form = $(form),
      action = $form.attr('action'),
      data = $form.serialize(),
      section = $form.parent();
  
  $.post(action + '.js', data, this.handleResponse.bind(this, section), 'html');

  e.preventDefault();
}

MTNT.Vote.prototype.handleResponse = function(section, response) {
	section.html(response);
}
