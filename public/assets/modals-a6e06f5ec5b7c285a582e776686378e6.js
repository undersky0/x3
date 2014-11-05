(function() {
  $('a[data-toggle=modal]').on('click', function() {
    return $('.dropdown').removeClass('open');
  });

  $('a[data-target=#ajax-modal]').on('click', function(e) {
    e.preventDefault();
    e.stopPropagation();
    return $.rails.handleRemote($(this));
  });

  $(document).on('click', '[data-dismiss=modal], .modal-scrollable', function() {
    return $('.modal-body-content').empty();
  });

  $(document).on('click', '#ajax-modal', function(e) {
    console.log("modal clicked");
    return e.stopPropagation();
  });

}).call(this);
