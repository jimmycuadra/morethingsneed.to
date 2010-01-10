MTNT.Entry = function(options) {
  this.$form = options.$form;
  this.$container = options.$container;
  this.flash = options.flash;

  this.$form.submit(this.handleSubmit.bind(this));
}

MTNT.Entry.prototype.handleSubmit = function(e, form) {
  var $form = $(form),
      action = $form.attr('action'),
      data = $form.serialize();
  
  $.post(action, data, this.handleResponse.bind(this), 'json');
  
  e.preventDefault();
}

MTNT.Entry.prototype.handleResponse = function(response) {
  if (response.success) {
    this.$form[0].reset();
    this.$form.formDefaults();
    this.flash.update(response.success, response.message);
    this.insert(response.entry);
  } else {
    this.flash.update(response.success, response.message, response.errors)
  }
}

MTNT.Entry.prototype.insert = function(entry) {
  $(entry).css('opacity', 0)
  .prependTo(this.$container.selector)
  .animate({
    opacity: '1',
  }, 'normal')
}
