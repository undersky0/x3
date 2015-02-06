jQuery ->
  
if $('.pagination').length
    $(window).scroll ->
            url = $('.pagination .next a').attr('href')
            if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
                    console.log("Url found: " + url)
                    $('.pagination').text('Fetching more posts...')
                    $.getScript(url)
 $(window).scroll()  
 

