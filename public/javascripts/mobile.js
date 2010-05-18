$(function() {
    // form defaults
	$('#add form').formDefaults();
	
	// notification
	var notification = new MTNT.Notification('notification');
	
	// flash
	var flash = new MTNT.Flash($('.flash'));
	
	// hide scrollbar
	window.scrollTo(0, 1);
});
