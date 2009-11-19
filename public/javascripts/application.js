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
			handleVote($this.parent('section.links'), data);
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
	$('nav span a[href="/register"], nav span a[href="/login"]').toggle(
		function() {
			var $op = $(this).attr('href');

			$(this).css('font-weight: bold');
			
			if ($op == "/register") {
				$('#logbox').html('<form action="/users" class="new_user" id="new_user" method="post"><div style="margin:0;padding:0;display:inline"><input name="authenticity_token" type="hidden" value="Oi6puygZD9wFig4z5fB74W+ZkAc0zRjJSpjv2IrzUVQ=" /></div><fieldset><legend>Create a new account</legend><label for="user_username">Username</label><input id="user_username" name="user[username]" size="30" type="text" /><label for="user_email">E-mail</label><input id="user_email" name="user[email]" size="30" type="text" /><label for="user_password">Password</label><input id="user_password" name="user[password]" size="30" type="password" /><label for="user_password_confirmation">Confirm password</label><input id="user_password_confirmation" name="user[password_confirmation]" size="30" type="password" /><input id="user_submit" name="commit" type="submit" value="Create account" /></fieldset></form>');
				$('#logbox').slideDown(500);
				$('#user_username').focus();
				return false;
			} else if ($op == "/login") {
				$('#logbox').html('<form action="/user_sessions" class="new_user_session" id="new_user_session" method="post"><div style="margin:0;padding:0;display:inline"><input name="authenticity_token" type="hidden" value="Oi6puygZD9wFig4z5fB74W+ZkAc0zRjJSpjv2IrzUVQ=" /></div><fieldset><legend>Log in</legend><label for="user_session_username">Username</label><input id="user_session_username" name="user_session[username]" size="30" type="text" /><label for="user_session_password">Password</label><input id="user_session_password" name="user_session[password]" size="30" type="password" /><input id="user_session_submit" name="commit" type="submit" value="Log in" /></fieldset></form>');
				$('#logbox').slideDown(500);
				$('#user_session_username').focus();
				return false;
			}
		},
		function() {
			var $op = $(this).attr('href');

			$('#logbox').slideUp(500);
			$('#logbox').html('').fadeOut(1000);
			return false;
		}
	);
	$('#logbox').blur(function() {
		console.log("logbox blurred");
		$(this).hide();
	});
	$('#logbox').focus(function() {
		console.log("logbox focused");
	});
});

function handleVote(section, data) {
	section.find('form:first').remove();
	if (data.success) {
		section.find('form').replaceWith('<em>Voted and noted.</em>')
		section.find('span').html(data.counts);
	} else {
		section.find('form').replaceWith('<em>You already rocked the vote.</em>')
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