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
});