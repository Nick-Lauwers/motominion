$(function() {

  // header-secondary
  
    // search bar
    
      var search = $('.header-icon');
      var form   = $('.search-form-secondary');
      var close  = $('.search-bar-secondary-close');
      
      search.click(function() {
        form.fadeIn(300);
      });
      
      close.click(function() {
        form.fadeOut(300);
      });
    
    // dependent dropdown
    
      var vehicleModelSelect = 
        $('#vehicle_vehicle_model_id.header-form-control.header-select-secondary');
      var vehicleMakeSelect =
        $('#vehicle_vehicle_make_id.header-form-control.header-select-primary');
      var vehicle_models = vehicleModelSelect.html();
        
      vehicleModelSelect.prop("disabled", true);
      
      vehicleMakeSelect.change(function() {
        
        var vehicle_make = 
          $('#vehicle_vehicle_make_id.header-form-control.header-select-primary :selected').
            text();
        var escaped_vehicle_make = 
          vehicle_make.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
        var options = 
          $(vehicle_models).
            filter("optgroup[label=" + escaped_vehicle_make + "]").
            html();
        
        if (options) {
          vehicleModelSelect.html(options);
          vehicleModelSelect.prop("disabled", false);
        } 
        
        else {
          vehicleModelSelect.empty();
          vehicleModelSelect.prop("disabled", true);
        }
      });
    
  // hero-backend
  
    // image scaling
    
      var heroAvatar = $('.hero-avatar');
      
      heroAvatar.imagefill(); 
});