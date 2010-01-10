$(function() {
  // form defaults
	$('#add form').formDefaults();
	
	// flash
	var flash = new MTNT.Flash($('.flash'));
	
	// userbox
  new MTNT.Userbox({
    links: $('#nav .user a'),
    userBoxes: $('.userbox')
  });
  
  // new entries
  new MTNT.Entry({
    $form: $('#new_entry'),
    $container: $('#entries'),
    flash: flash
  });
  
  // votes
  new MTNT.Vote($('form.new_vote'));
  
  // contact form
  new MTNT.Contact({
    $form: $('#new_contact'),
    flash: flash
  });
	
	$('#new_comment').submit(function(e) {
		if (/*@cc_on!@*/0) {
			return true;
		}
		var $this = $(this);
		$.post($this.attr('action'), $this.serialize(), function(data) {
			handleComment($this, data);
		}, 'json');
		e.preventDefault();
	});

});

function handleComment(commentForm, data) {
	updateFlash(data.flash);
	
	$('.validation-errors').remove();
	
	if (data.success) {
		$('#comments').append('<article class="hidden"><section>' + data.comment + '</section><footer>You were quite thoughtful, don\'t you think?<time>Just now</time></footer></article>');
		$('#comments article.hidden').animate({
			'height': 'toggle',
			'opacity': 'toggle'
		}, 'slow');
	} else {
		commentForm.prepend('<div class="validation-errors"><header><p>You fucked up.</p></header><ul><li>' + data.errors.join('</li><li>') + '</li></ul></div>');
	}
}
