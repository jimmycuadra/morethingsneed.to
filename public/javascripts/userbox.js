MTNT.Userbox = function() {
  MTNT.Userbox.bindClick($('#nav .user a'));  
}

MTNT.Userbox.bindClick = function($links) {
  $links.each(function() {
    $(this).click(function(e) {
      var $this = $(this),
          $thisBox = $('#' + $this.attr('id') + '-box'),
          $otherBox = $('.userbox').not('#' + $this.attr('id') + '-box');

      e.preventDefault();

      if ($otherBox.css('display') == 'block') {
        $otherBox.slideUp(100, function() {
          $thisBox.slideToggle(250);
        });
      } else {
        $thisBox.slideToggle(250);
      }
    });
  });
}

$(MTNT.Userbox);