(function() {
  var ready;

  ready = function() {
    return $(document).trigger('refresh_autonumeric');
  };

  $(document).ready(ready);

  $(document).on('page:load', ready);

}).call(this);
