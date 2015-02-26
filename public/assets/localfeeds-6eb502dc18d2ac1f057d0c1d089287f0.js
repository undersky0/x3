(function() {
  jQuery(function() {});

  if ($('.pagination').length) {
    $(window).scroll(function() {
      var url;
      url = $('.pagination .next a').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        console.log("Url found: " + url);
        $('.pagination').text('Fetching more posts...');
        return $.getScript(url);
      }
    });
  }

  $(window).scroll();

}).call(this);
