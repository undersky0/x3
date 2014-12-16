$(function() {
	var inbox = $('#selectAllinbox');
	var sent = $('#selectAllsent');
	var trash = $('#selectAlltrash');
	$(sent).add(inbox).add(trash).click(function() {
   if (this.checked) {
       $(':checkbox').each(function() {
           this.checked = true;                        
       });
   } else {
      $(':checkbox').each(function() {
           this.checked = false;                        
       });
   }
});
});
// 
  // $('#id_').change(function() {
  // if ( $('#id_').prop("checked") ) {
          // $('#submit').attr('disabled', false);
              // } else {
          // $('#submit').attr('disabled', true);
        // }
    // });


