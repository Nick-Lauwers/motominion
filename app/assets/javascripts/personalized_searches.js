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
    
  // style
  
    // disable save
      
      var styleCheckboxes = $('.style-checkbox');
      var styleButton     = $('.style-button');
      
      styleCheckboxes.change(function () {
        styleButton.prop('disabled', styleCheckboxes.filter(':checked').length < 1);
      });
      
      styleCheckboxes.change();
  
  // manufacturer
  
    // disable save
      
      var manufacturerCheckboxes = $('.manufacturer-checkbox');
      var manufacturerButton     = $('.manufacturer-button');
      
      manufacturerCheckboxes.change(function () {
        manufacturerButton.prop('disabled', manufacturerCheckboxes.filter(':checked').length < 1);
      });
      
      manufacturerCheckboxes.change();
  
    // expand options
    
      var personalizedSearchManufacturer = $('.personalized-search-manufacturer');
      var personalizedSearchExpand       = $('.personalized-search-expand-content');
      var manufacturerInitialHeight      = 260;
  
      personalizedSearchManufacturer.each(function() {
        $.data(this, "realHeight", $(this).height());
      }).css({ height: manufacturerInitialHeight + 'px' });
      
      personalizedSearchExpand.click(function(e) {
        e.preventDefault();
        
        if (personalizedSearchManufacturer.hasClass("toggled")) {
          personalizedSearchManufacturer.animate({ 
            height: manufacturerInitialHeight
          }, 600).removeClass("toggled");
          personalizedSearchExpand.html("+ More");
        } 
        
        else {
          personalizedSearchManufacturer.animate({ 
            height: personalizedSearchManufacturer.data("realHeight") 
          }, 600).addClass("toggled");
          personalizedSearchExpand.html("- Less");
        }
      });
});