$(function() { 
  
  // list
  
    // image scaling
    var newVehicleGallery = $('.new-vehicle-gallery')
    var newVehiclePhoto   = $('.new-vehicle-gallery')
    
    newVehicleGallery.imagesLoaded( function() {
      newVehiclePhoto.imagefill(); 
    });
});