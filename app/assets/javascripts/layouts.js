$(function() {

  // header-secondary
  
    // search bar
    
      var icon  = $('.header-icon-desktop');
      var form  = $('.search-form-secondary');
      var close = $('.search-bar-secondary-close');
      
      icon.click(function() {
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
      
    // modal
    
      var headerIconSearch = $('.header-icon-search');
      var headerIconMenu   = $('.header-icon-menu');
      var modalSearch      = $('#modal-search');
      var modalMenu        = $('#modal-menu');
      
      headerIconSearch.click(function() {
        
        if (headerIconSearch.hasClass('header-icon-inactive')) {
          headerIconSearch.removeClass('header-icon-inactive').addClass('header-icon-active');
          headerIconMenu.removeClass('header-icon-active').addClass('header-icon-inactive');
        	modalSearch.modal('show');
        	modalMenu.modal('hide');
        }
        
        else {
          headerIconSearch.removeClass('header-icon-active').addClass('header-icon-inactive');
        	modalSearch.modal('hide');
        }
      });
      
      headerIconMenu.click(function() {
        
        if (headerIconMenu.hasClass('header-icon-inactive')) {
        	headerIconSearch.removeClass('header-icon-active').addClass('header-icon-inactive');
          headerIconMenu.removeClass('header-icon-inactive').addClass('header-icon-active');
        	modalSearch.modal('hide');
        	modalMenu.modal('show');
        }
        
        else {
          headerIconMenu.removeClass('fa-close header-icon-active').addClass('fa-bars header-icon-inactive');
        	modalMenu.modal('hide');
        }
      });
    
  // hero-backend
  
    // image scaling
    
      var heroAvatar = $('.hero-avatar');
      
      heroAvatar.imagefill(); 
});