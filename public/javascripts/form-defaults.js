;(function($) {
  $.fn.formDefaults = function() {
    
    return this.each(function() {
      
      var $inputs = $(this).find('input[type=text]').css('color', '#666'),
          defaultFormValues = new Array();
          
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
      });
    });
    
  };
}) (jQuery);