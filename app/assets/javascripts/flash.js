MTNT.Flash = function($container) {
  this.$container = $container;
  this.$closeButton = $container.find('.close').removeClass('hidden');
  this.$message = $container.find('.message');
  this.$errors = $container.find('.errors');

  this.$closeButton.on("click", this.handleClose.bind(this));
};

MTNT.Flash.prototype.handleClose = function() {
	this.$container.addClass('hidden');
};

MTNT.Flash.prototype.update = function(success, message, errors) {
  if (typeof errors == 'undefined' || success) {
    errors = '';
  }

  if (success) {
    this.$container.addClass('success');
  } else {
    this.$container.removeClass('success');
  }

  this.$message.html(message);
  this.$errors.html(errors);
  this.$container.removeClass('hidden');
};
