MTNT.Contact = function(options) {
  this.$form = options.$form;
  this.flash = options.flash;

  this.$form.on("submit", this.handleSubmit.bind(this));
};

MTNT.Contact.prototype.handleSubmit = function(e) {
  var $form = $(e.target),
      action = $form.attr('action'),
      data = $form.serialize();

  $.post(action, data, this.handleResponse.bind(this), 'json');

  e.preventDefault();
};

MTNT.Contact.prototype.handleResponse = function(response) {
  if (response.success) {
    this.$form[0].reset();
    this.flash.update(response.success, response.message);
  } else {
    this.flash.update(response.success, response.message, response.errors);
  }
};
