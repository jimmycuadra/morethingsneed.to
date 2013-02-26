MTNT.Entry = function(options) {
  this.$form = options.$form;
  this.$container = options.$container;
  this.flash = options.flash;

  this.$form.on("submit", this.handleSubmit.bind(this));
};

MTNT.Entry.prototype.handleSubmit = function(e) {
  var $form = $(e.target),
      action = $form.attr('action'),
      data = $form.serialize();

  $.post(action, data, this.handleResponse.bind(this), 'json');

  e.preventDefault();
};

MTNT.Entry.prototype.handleResponse = function(response) {
  if (response.success) {
    this.$form[0].reset();
    this.$form.find('input[type=text]').css('color', '#666');
    this.flash.update(response.success, response.message);
    this.insert(response.entry);
  } else {
    this.flash.update(response.success, response.message, response.errors);
  }
};

MTNT.Entry.prototype.insert = function(entry) {
  $(entry).css('opacity', 0)
  .prependTo(this.$container.selector)
  .animate({
    opacity: '1'
  }, 'normal');
};
