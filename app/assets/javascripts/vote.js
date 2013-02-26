MTNT.Vote = function(formSelector) {
  $(document).on('submit', formSelector, this.handleSubmit.bind(this));
};

MTNT.Vote.prototype.handleSubmit = function(e) {
  var $form = $(e.target),
      action = $form.attr('action'),
      data = $form.serialize(),
      section = $form.parent();

  $.post(action + '.json', data, this.handleResponse.bind(this, section), 'html');

  e.preventDefault();
};

MTNT.Vote.prototype.handleResponse = function(section, response) {
  section.html(response);
};
