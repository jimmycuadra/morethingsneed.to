MTNT.Vote = function($forms) {
  this.$forms = $forms;
  
  this.$forms.live('submit', this.handleSubmit.bind(this));
};

MTNT.Vote.prototype.handleSubmit = function(e, form) {
  var $form = $(form),
      action = $form.attr('action'),
      data = $form.serialize(),
      section = $form.parent();

  $.post(action, data, this.handleResponse.bind(this, section), 'json');

  e.preventDefault();
};

MTNT.Vote.prototype.handleResponse = function(section, response) {
	section.empty();
	$("#tmpl-vote").tmpl(response).appendTo(section);
};
