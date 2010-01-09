$(function() {
  // form defaults
	$('#add form input[type=text]').formDefaults();
	
	// flash
	var flash = new MTNT.Flash($('.flash'));
	
	// userbox
  new MTNT.Userbox({
    links: $('#nav .user a'),
    userBoxes: $('.userbox')
  });
  
  // votes
  new MTNT.Vote($('form.new_vote'));
	
	$('#content.main form.new_entry').submit(function(e) {
		if (/*@cc_on!@*/0) {
			return true;
		}
		var $this = $(this);
		$.post('/entries', $this.serialize(), function(data) {
			handleEntry($this, data);
		}, 'json');
		e.preventDefault();
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

function handleEntry(addForm, data) {
	updateFlash(data.flash);
	
	$('.validation-errors').remove();

	if (data.success) {
		var needs;
		
		if (data.entry.needs) {
			needs = 's';
		} else {
			needs = '';
		}
		
		$('#entries').prepend('<article class="hidden"><header>You crapped this out just now.</header><section><p>More ' + data.entry.noun + ' need' + needs + ' to ' + data.entry.verb + '.</p><section class="links"><a href="/entries/' + data.entry.id + '">On to the comments!</a></section></section></article>');
		$('#entries article.hidden').animate({
			'height': 'toggle',
			'opacity': 'toggle'
		}, 'slow');
	} else {
		addForm.append('<div class="validation-errors"><header><p>You fucked up.</p></header><ul><li>' + data.errors.join('</li><li>') + '</li></ul></div>');
	}
}

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
