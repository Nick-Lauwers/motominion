$(function() {
  
  // home
  
    $(window).on('scroll', function() {
      
      // fixed header
        var fixedHeader = $('.header-fixed-hidden');
        var scrolltop   = $(this).scrollTop();
        
        if(scrolltop >= 315) {
          fixedHeader.fadeIn(250);
        }
        else if(scrolltop <= 310) {
          fixedHeader.fadeOut(250);
        }
    });
    
    // smooth scroll
      var popularSearchesLink = $(".popular-searches a")
      
      popularSearchesLink.click(function(evn){
        evn.preventDefault();
        $('html, body').scrollTo(this.hash, this.hash, { offset: -50 }); 
      });
});