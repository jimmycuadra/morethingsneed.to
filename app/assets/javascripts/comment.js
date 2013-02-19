MTNT.Comment = function(options) {
  this.$form = options.$form;
  this.$container = options.$container;
  this.flash = options.flash;

  this.$form.submit(this.handleSubmit.bind(this));
};

MTNT.Comment.prototype.handleSubmit = function(e, form) {
  var $form = $(form),
      action = $form.attr('action'),
      data = $form.serialize();

  $.post(action, data, this.handleResponse.bind(this), 'json');

  e.preventDefault();
};

MTNT.Comment.prototype.handleResponse = function(response) {
  if (response.success) {
    this.$form[0].reset();
    this.flash.update(response.success, response.message);
    this.insert(response.comment);
  } else {
    this.flash.update(response.success, response.message, response.errors);
  }
};

MTNT.Comment.prototype.insert = function(comment) {
  if (this.$container.hasClass('empty-state')) {
    this.$container.removeClass('empty-state').empty();
  }

  $(comment).css('opacity', 0)
  .appendTo(this.$container.selector)
  .animate({
    opacity: '1'
  }, 'normal');
};
