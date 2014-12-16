(function() {
  console.log("Creating pagination callback");

  jQuery(function() {});

  console.log("Creating pagination callback");

  if ($('.pagination').length) {
    console.log("Pagination detected");
  }

  $(window).scroll(function() {
    var url;
    console.log("Scroll detected");
    url = $('.pagination .next a').attr('href');
    console.log("Url found: " + url);
    if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
      console.log("Url found: " + url);
      $('.pagination').text('Fetching more posts...');
      $.getScript(url);
      console.log("Script loaded");
      return console.log("Url found: " + url);
    }
  });

  $(window).scroll();

}).call(this);
