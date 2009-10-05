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
		$this = $(this);
		$.post($this.attr('action'), $this.serialize(), function(data) {
			handleVote($this.parent('section.links'), data);
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