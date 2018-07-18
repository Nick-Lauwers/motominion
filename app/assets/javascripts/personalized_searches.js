$(function() {
  
  // form
    
    var searchPersonalizationClose = $('.search-personalization-close');
    var searchPersonalization      = $('.search-personalization');
    
    searchPersonalizationClose.click(function () {
      searchPersonalization.css("display", "none");
    });
    
    var searchPersonalizationLeft       = $('.search-personalization-left');
    var searchPersonalizationRight      = $('.search-personalization-right');
    var searchPersonalizationParameters = 
          $('.search-personalization-parameters')
    
    searchPersonalizationLeft.click(function() {
      
      event.preventDefault();
      
      searchPersonalizationParameters.animate({
        scrollLeft: "-=200px"
      }, "slow");
    });
    
    searchPersonalizationRight.click(function() {
      
      event.preventDefault();
      
      searchPersonalizationParameters.animate({
        scrollLeft: "+=200px"
      }, "slow");
    });

  // show
    
    var matchesIntroductionClose = $('.matches-introduction-close');
    var matchesIntroduction      = $('.matches-introduction');
    
    matchesIntroductionClose.click(function () {
      matchesIntroduction.css("display", "none");
    });
});