MTNT.Userbox = function(options) {
  this.$links = options.links,
  this.$userBoxes = options.userBoxes,
  this.$thisBox,
  this.$otherBox;
  
  this.$links.each(function(i, link) {    
    $(link).click(this.handleClick.bind(this));
  }.bind(this));
}

MTNT.Userbox.prototype.handleClick = function(e, link) {
  var $link = $(link),
      boxSelector = '#' + $link.attr('id') + '-box';

  this.$thisBox = $(boxSelector);
  this.$otherBox = this.$userBoxes.not(boxSelector);

  this.animateBoxes();
  e.preventDefault();
}

MTNT.Userbox.prototype.animateBoxes = function() {
  if (this.$otherBox.css('display') == 'block') {
    this.$otherBox.slideUp(100, function() {
      this.$thisBox.slideToggle(250);
    }.bind(this));
  } else {
    this.$thisBox.slideToggle(250);
  }
}
