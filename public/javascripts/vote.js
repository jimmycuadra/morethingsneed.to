MTNT.Vote = function() {
  MTNT.Vote.bindSubmit();
}

MTNT.Vote.bindSubmit = function() {
  $('form.new_vote').submit(function(e) {
    var $this = $(this),
        action = $this.attr('action'),
        data = $this.serialize();

    e.preventDefault();

    $.post(action + '.js', data, function(response) {
      MTNT.Vote.handleVote($this.parent('.section-links'), response);
    }, 'html');
  });
}

MTNT.Vote.handleVote = function(section, response) {
	section.html(response);
}

$(MTNT.Vote);