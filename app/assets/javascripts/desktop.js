//= require core
//= require jquery_ujs
//= require jquery.cookie
//= require notification
//= require flash
//= require userbox
//= require entry
//= require vote
//= require comment
//= require contact

$(function() {
	// notification
	var notification = new MTNT.Notification('notification');

	// flash
	var flash = new MTNT.Flash($('.flash'));

	// userbox
  new MTNT.Userbox({
    links: $('#nav .user:not(.logged-in) a:not(.current)'),
    userBoxes: $('.userbox')
  });

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
  new MTNT.Vote('form.new_vote');

  // contact form
  new MTNT.Contact({
    $form: $('#new_contact'),
    flash: flash
  });
});
