$(document).on('turbolinks:load', function() {
  var filePlug = $('a[href="#files"]').last();

  filePlug.on('click', function() {
    $('.active').first().removeClass('active');
    $('a[href="#files"]').first().parent().addClass('active');
  });
});

