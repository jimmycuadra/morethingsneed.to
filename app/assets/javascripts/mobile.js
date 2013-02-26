//= require core
//= require jquery_ujs
//= require vote

$(function() {
	// votes
	new MTNT.Vote($('form.new_vote'));

	// hide scrollbar
	window.scrollTo(0, 1);
});
