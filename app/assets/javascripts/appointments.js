$(function() {

  // form

    // smooth scroll
      var availabilityLink = $('.availability-link');
    
      availabilityLink.click(function(evn) {
        evn.preventDefault();
        $('html, body').animate({
            scrollTop: $('#availability').offset().top-50
        }, 'slow');
      });

    // datetimepicker
      var appointmentTime = $('#appointment-time');
      
      $(function () {
        appointmentTime.datetimepicker({
          format: 'YYYY-MM-DD LT'
        });
      });
});