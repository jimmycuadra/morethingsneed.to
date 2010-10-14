$(function() {
    // form defaults
	$('#add form').formDefaults();

	// votes
	new MTNT.Vote($('form.new_vote'));
	
	// hide scrollbar
	window.scrollTo(0, 1);
});
