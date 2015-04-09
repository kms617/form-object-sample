$(document).ready(function() {
    var text_max = 140;
    var text_length = $('#bio').val().length;
    var text_remaining = text_max - text_length;

    $('.js-char-count').text(text_remaining + ' characters left');

    $('#bio').on('input', function() {
        var text_length = $('#bio').val().length;
        var text_remaining = text_max - text_length;

        $('.js-char-count').text(text_remaining + ' characters left');
    });

    $('#enrollment_form_first_name').on('input', function() {
      writeName();
    });

   $('#enrollment_form_last_name').on('input', function() {
     writeName();
  });

    function writeName() {
      var firstName = $('#enrollment_form_first_name').val();
      var lastName = $('#enrollment_form_last_name').val();

       if (firstName === "" && lastName === "") {
         $('.js-employee-name').text("New Employee");
       } else {
         $('.js-employee-name').text(firstName + " " + lastName);
       }
    }
});
