$(function() {
    // form defaults
	$('#add form').formDefaults();
	
	// notification
	var notification = new MTNT.Notification('notification');
	
	// flash
	var flash = new MTNT.Flash($('.flash'));
	
	// new entries
	new MTNT.Entry({
	    $form: $('.ajax #new_entry'),
	    $container: $('#entries'),
	    flash: flash
	});

	// new comments
	new MTNT.Comment({
	    $form: $('#new_comment'),
	    $container: $('#comments'),
	    flash: flash
	});

	// votes
	new MTNT.Vote($('form.new_vote'));
	
	// hide scrollbar
	window.scrollTo(0, 1);
});
