$(function() { 
  
  // list
  
    // image scaling
    
      var newVehiclePhoto = $('.new-vehicle-photo')
      
      newVehiclePhoto.imagefill(); 
  
    // image rotation  

      $('.rotatable-image').each(function() {
        
        var deg = $(this).data('rotate') || 0;
        var rotate = 'rotate(' + deg + 'deg)';
        
        $(this).css({ 
            '-webkit-transform': rotate,
            '-moz-transform': rotate,
            '-o-transform': rotate,
            '-ms-transform': rotate,
            'transform': rotate 
        });
      });
});