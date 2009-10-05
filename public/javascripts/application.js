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
	
	$('form.new_vote').submit(function(e) {
		var $this = $(this);
		$.post($this.attr('action'), $this.serialize(), function(data) {
			handleVote($this.parent('section.links'), data);
		}, 'json');
		e.preventDefault();
	});
	
	$('form.new_entry').submit(function(e) {
		var $this = $(this);
		$.post('/entries', $this.serialize(), function(data) {
			handleEntry($this, data);
		}, 'json');
		e.preventDefault();
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
	var $flash = $('.flash');

	if (!$flash.length) {
		$('#content').before('<div class="flash">' + data.flash + '</div>');
	} else {
		$flash.html(data.flash);
	}
	
	$('.validation-errors').remove();

	if (data.success) {
		var needs;
		
		if (data.entry.needs) {
			needs = 's';
		} else {
			needs = '';
		}
		
		$('#entries').prepend('<article><header>You crapped this out just now.</header><section><p>More ' + data.entry.noun + ' need' + needs + ' to ' + data.entry.verb + '.</p><section class="links"><a href="/entries/' + data.entry.id + '">On to the comments!</a></section></section></article>');
	} else {
		addForm.append('<div class="validation-errors"><header><p>You fucked up.</p></header><ul><li>' + data.errors.join('</li><li>') + '</li></ul></div>');
	}
}