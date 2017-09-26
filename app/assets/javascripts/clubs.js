$(function() {

  // posts
  
    // fixed club profile navbar
        
      var clubProfileNavbar = $('.club-profile-navbar');
      var location          = $('.navbar-location-visible');
      var shareButton       = $('.btn-navbar-share-hidden');
    
      $(window).scroll(function() {
        
        var scrolltop = $(this).scrollTop();
        
        if(scrolltop >= 480) {
          clubProfileNavbar.addClass('club-profile-navbar-scrolled');
          location.addClass('navbar-location-hidden');
          shareButton.addClass('btn-navbar-share-visible');
        }
        
        else {
          clubProfileNavbar.removeClass('club-profile-navbar-scrolled');
          location.removeClass('navbar-location-hidden');
          shareButton.removeClass('btn-navbar-share-visible');
        }
      });
    
    // expand info
    
      var clubProfileHeroInfo   = $('.club-profile-hero-info');
      var clubProfileHeroExpand = $('.club-profile-hero-expand');
      var infoInitialHeight     = 38;
  
      clubProfileHeroInfo.each(function() {
        $.data(this, "realHeight", $(this).height());
      }).css({ overflow: "hidden", height: infoInitialHeight + 'px' });
      
      clubProfileHeroExpand.click(function(e) {
        e.preventDefault();
        
        if (clubProfileHeroInfo.hasClass("toggled")) {
          clubProfileHeroInfo.animate({ 
            height: infoInitialHeight
          }, 600).removeClass("toggled");
          clubProfileHeroExpand.html("+ More");
        } 
        
        else {
          clubProfileHeroInfo.animate({ 
            height: clubProfileHeroInfo.data("realHeight") 
          }, 600).addClass("toggled");
          clubProfileHeroExpand.html("- Less");
        }
      });
      
    // fixed listing
    
      var clubMapContainer = $('#club-map-container');
      
      clubMapContainer.stick_in_parent({ offset_top: 50 });
});
