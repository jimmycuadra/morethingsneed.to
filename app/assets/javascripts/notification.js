MTNT.Notification = function(id) {
  this.$frame = $('#' + id);
  this.$message = this.$frame.find('.message');
  this.$close = this.$frame.find('.close');

  this.isSeen();
};

MTNT.Notification.prototype.isSeen = function() {
  if ($.cookie('seen') !== 't') {
    if (window.location.pathname !== '/faq') {
      this.notify('First time here? Check out the <a href="/faq">FAQ</a> to see what it\'s all about.');
      this.$close.on("click", this.setSeen.bind(this));
    } else {
      this.setSeen();
    }
  }
};

MTNT.Notification.prototype.setSeen = function() {
  this.$frame.addClass('hidden');
  $.cookie('seen', 't', {
    expires: 18250,
    domain: location.hostname,
    path: '/'
  });
};

MTNT.Notification.prototype.notify = function(msg) {
  this.$message.html(msg);
  this.$frame.removeClass('hidden').animate({
    opacity: 1
  }, 'normal');
};
