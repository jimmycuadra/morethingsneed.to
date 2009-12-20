// keeps the desktop/mobile style preference
if($.cookie("css")) {
    $("link#main_style").attr("href", $.cookie("css"));
}

$(function() {
	var defaultFormValues = new Array();
	var $inputs = $('#add form input[type=text]').css('color', '#666');
	$inputs.focus(function() {
		$(this).css('color', '#000');
		
		if (!defaultFormValues[this.name]) {
			defaultFormValues[this.name] = this.value;
		}
		
		if (this.value == defaultFormValues[this.name]) {
			this.value = '';
		}
	});
	
	$inputs.blur(function() {
		if (this.value == '') {
			this.value = defaultFormValues[this.name];
			$(this).css('color', '#666');
		}
	})
	
	$('.flash .close').live('click', function() {
		$(this).parent().remove();
	});
	
	$('form.new_vote').submit(function(e) {
		var $this = $(this);
		$.post($this.attr('action'), $this.serialize(), function(data) {
			handleVote($this.parent('.section-links'), data);
		}, 'json');
		e.preventDefault();
	});
	
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
	
	$('#new_contact').submit(function(e) {
		var $this = $(this);
		$.post('/contact', $this.serialize(), function(data) {
			handleContact($this, data);
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
	
	// prepare the document on initial load
	var $cur_style = $('link#main_style').attr('href');

	if ($cur_style == "/stylesheets/screen-mobile.css") {
		$('#mobile').css('background-color', '#00ff00');
		if ($('#spacer').length) {
			return false;
		} else {
			$('nav span').before("<br id='spacer' />");
		}
	} else {
		$('#desktop').css('background-color', '#00ff00');
	}
	
	// change stylesheet on button click
	$('#style_switcher input').click(function() {
		var $this = $(this);
		
		// set the css file to the rel attribute in the button
		$('link#main_style').attr('href', $this.attr('rel'));
		// save the preference in a cookie
		$.cookie("css", $this.attr('rel'), {expires: 365, path: '/'});
		// are we now on the mobile stylesheet?
		if ($('link#main_style').attr('href') == "/stylesheets/screen-mobile.css") {
			// if spacer exists, move on
			if($('#spacer').length) {
				return false;
			// if not, add it
			} else {
				$('nav span').before("<br id='spacer' />");
			}
		} else {
			if($('#spacer').length) { $('#spacer').remove(); }
		}
		
		// color all inputs gray
		$('#style_switcher input').each(function() {
			$(this).css('background-color', '#c0c0c0');
		});
		
		// highlight button clicked
		$this.css('background-color', '#00ff00');
		
		return false;
	});

	// toggle register/login box
	$('#register').click(function(e) {
		e.preventDefault();
		
		var $loginBox = $('#login-box');
				
		if ($loginBox.css('display') == 'block') {
			$loginBox.slideUp(100, function() {
				$('#register-box').slideToggle(250);
			});
		} else {
			$('#register-box').slideToggle(250);
		}
	});
	
	$('#login').click(function(e) {
		e.preventDefault();
		
		var $registerBox = $('#register-box');
		
		if ($registerBox.css('display') == 'block') {
			$registerBox.slideUp(100, function() {
				$('#login-box').slideToggle(250);
			});			
		} else {
			$('#login-box').slideToggle(250);	
		}
	});	
});

function handleVote(section, data) {
	section.find('form').remove();
	
	if (data.success) {
		section.prepend('<span class="success">Voted and noted.</span><br />');
		section.find('span.up_vote_count').html(data.up_count);
		section.find('span.down_vote_count').html(data.down_count);
	} else {
		section.prepend('<span class="error">You already rocked the vote.</span><br />')
	}
}

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

function handleContact(contactForm, data) {
	updateFlash(data.flash);
	
	$('.validation-errors').remove();
	
	if (data.success) {
		contactForm[0].reset();
	} else {
		contactForm.prepend('<div class="validation-errors"><header><p>You fucked up.</p></header><ul><li>' + data.errors.join('</li><li>') + '</li></ul></div>');
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

function updateFlash(message) {
	var $flash = $('.flash');

	if (!$flash.length) {
		$('#content').before('<div class="flash"><div class="close"></div>' + message + '</div>');
	} else {
		$flash.html('<div class="close"></div>' + message);
	}
}