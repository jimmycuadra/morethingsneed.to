if (typeof MTNT == 'undefined') {
  MTNT = {};
}

MTNT.StylesheetSwitcher = function() {
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
}

$(MTNT.StylesheetSwitcher);
