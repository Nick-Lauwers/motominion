$(function() {
  
  // new
  
    // dependent dropdown
      
      var vehicleModelPost   = $('#vehicle-model-post');
      var vehicleMakePost    = $('#vehicle-make-post');
      var vehicle_model_post = vehicleModelPost.html();
        
      vehicleModelPost.prop("disabled", true);
      
      vehicleMakePost.change(function() {
        
        var vehicle_make_post = $('#vehicle-make-post :selected').text();
        var escaped_vehicle_make_post = 
          vehicle_make_post.
            replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
        var options_post = 
          $(vehicle_model_post).
            filter("optgroup[label=" + escaped_vehicle_make_post + "]").
            html();
        
        if (options_post) {
          vehicleModelPost.html(options_post);
          vehicleModelPost.prop("disabled", false);
        } 
        
        else {
          vehicleModelPost.empty();
          vehicleModelPost.prop("disabled", true);
        }
      });
      
  // post_desktop
  
    // retract caption
    
      var postDesktopHideInfo         = $('.post-desktop-hide-info');
      var postDesktopHideInfoText     = $('.post-desktop-hide-info-text');
      var postDesktopGallery          = $('.post-desktop-gallery');
      var postDesktopCaptionContainer = $('.post-desktop-caption-container');
      
      postDesktopHideInfo.click(function(e) {
        e.preventDefault();
        
        if (postDesktopGallery.hasClass('post-desktop-gallery-open')) {
          postDesktopHideInfoText.html("- Hide");
          postDesktopGallery.removeClass('post-desktop-gallery-open');
          postDesktopCaptionContainer.removeClass('post-desktop-caption-container-closed');
        } 
        
        else {
          postDesktopHideInfoText.html("+ Info");
          postDesktopGallery.addClass('post-desktop-gallery-open');
          postDesktopCaptionContainer.addClass('post-desktop-caption-container-closed');
        }
      });
});