$(function() {

  // form
    
    // smooth scroll
    
      var availabilityLink         = $('.availability-link');
      var testDriveSidenavInfoLink = $('.test-drive-sidenav-info a');
    
      availabilityLink.click(function(evn) {
        evn.preventDefault();
        $('html, body').animate({
            scrollTop: $('#availability').offset().top-50
        }, 'slow');
      });
      
      testDriveSidenavInfoLink.click(function(evn) {
        evn.preventDefault();
        $('html, body').animate({
            scrollTop: $('#availability').offset().top-50
        }, 'slow');
      });

    // datetimepicker
    
      var appointmentTime = $('#appointment-time');
      
      $(function () {
        appointmentTime.datetimepicker({
          format:            'YYYY-MM-DD LT',
          minDate:           Date(),
          widgetPositioning: { horizontal: 'auto', vertical: 'bottom' }
        });
      });
    
    // list scroll
      
      var testDriveSidenavLeft   = $('.test-drive-sidenav-left');
      var testDriveSidenavRight  = $('.test-drive-sidenav-right');
      var testDriveSidenavScroll = $('.test-drive-sidenav-scroll');

      testDriveSidenavLeft.click(function() {
        
        event.preventDefault();
        
        testDriveSidenavScroll.animate({
          scrollLeft: "-=150px"
        }, "slow");
      });
      
      testDriveSidenavRight.click(function() {
        
        event.preventDefault();
        
        testDriveSidenavScroll.animate({
          scrollLeft: "+=150px"
        }, "slow");
      });
});