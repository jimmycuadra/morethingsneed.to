$(function() {
  // form defaults
	$('#add form').formDefaults();
	
	// flash
	var flash = new MTNT.Flash($('.flash'));
	
	// userbox
  new MTNT.Userbox({
    links: $('#nav .user a'),
    userBoxes: $('.userbox')
  });
  
  // new entries
  new MTNT.Entry({
    $form: $('#new_entry'),
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
  
  // contact form
  new MTNT.Contact({
    $form: $('#new_contact'),
    flash: flash
  });
});
