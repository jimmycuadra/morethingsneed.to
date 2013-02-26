MTNT.Userbox = function(options) {
  this.$links = options.links;
  this.$userBoxes = options.userBoxes;
  this.$thisBox = null;
  this.$otherBox = null;

  this.$links.on("click", this.handleClick.bind(this));
};

MTNT.Userbox.prototype.handleClick = function(e) {
  var $link = $(event.target),
      boxSelector = '#' + $link.attr('id') + '-box';

  this.$thisBox = $(boxSelector);
  this.$otherBox = this.$userBoxes.not(boxSelector);

  this.animateBoxes(this.focusFirstField.bind(this));
  e.preventDefault();
};

MTNT.Userbox.prototype.animateBoxes = function(callback) {
  if (this.$otherBox.css('display') == 'block') {
    this.$otherBox.slideUp(100, function() {
      this.$thisBox.slideToggle(250, callback);
    }.bind(this));
  } else {
    this.$thisBox.slideToggle(250, callback);
  }
};

MTNT.Userbox.prototype.focusFirstField = function() {
  if (this.$thisBox.css('display') == 'block') {
    this.$thisBox.find('input:visible:first').focus();
  }
};
