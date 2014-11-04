$(document).ready(function(){
  var profiles = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
  limit: 10,
    remote: {
      url: '/search/tokenquery?q=%QUERY'
       ,
       filter: function(results){

       	var tagged_user = $('#to-tags').tokenfield('getTokens');
       	return $.map(results.users, function (user) {
       				var exists = false;
                    for (i=0; i < tagged_user.length; i++) {
                        if (user.user_id == tagged_user[i].value) {
                            var exists = true;
                        }
                    }
                    if (!exists) {
                        return {
                            value: user.id,
                            label: user.name
                        };
                    }
              });
                        }
                       }
                       
    });
    
  profiles.initialize();
  
$('#to-tags').tokenfield({
        delimiter: ',',
        beautify: true,
        typeahead: [
            {
                hint: false
            }, 
            {
                name: 'users',
                displayKey: 'label',
                source: profiles.ttAdapter()
            }
        ]
   }).on('tokenfield:createtoken', function (e) {
   	
        var existingTokens = $(this).tokenfield('getTokens');
        if (existingTokens.length) {
            $.each(existingTokens, function(index, token) {
                if (token.value === e.attrs.value) {
                    e.preventDefault();
                }
            });
        }
    });
 });