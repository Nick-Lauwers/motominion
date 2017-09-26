$(function() {
  
  // general
  
    // floating action button
      
        var actionButton = $('.action-button');
      
        actionButton.on('click', function(){
          $(this).toggleClass('active');
        })

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
    
      var vehicleModelHeader   = $('#vehicle-model-header');
      var vehicleMakeHeader    = $('#vehicle-make-header');
      var vehicle_model_header = vehicleModelHeader.html();
        
      vehicleModelHeader.prop("disabled", true);
      
      vehicleMakeHeader.change(function() {
        
        var vehicle_make_header = $('#vehicle-make-header :selected').text();
        var escaped_vehicle_make_header = 
          vehicle_make_header.
            replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
        var options_header = 
          $(vehicle_model_header).
            filter("optgroup[label=" + escaped_vehicle_make_header + "]").
            html();
        
        if (options_header) {
          vehicleModelHeader.html(options_header);
          vehicleModelHeader.prop("disabled", false);
        } 
        
        else {
          vehicleModelHeader.empty();
          vehicleModelHeader.prop("disabled", true);
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
      
      var vehicleModelModal   = $('#vehicle-model-modal');
      var vehicleMakeModal    = $('#vehicle-make-modal');
      var vehicle_model_modal = vehicleModelModal.html();
        
      vehicleModelModal.prop("disabled", true);
      
      vehicleMakeModal.change(function() {
        
        var vehicle_make_modal = $('#vehicle-make-modal :selected').text();
        var escaped_vehicle_make_modal = 
          vehicle_make_modal.
            replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
        var options_modal = 
          $(vehicle_model_modal).
            filter("optgroup[label=" + escaped_vehicle_make_modal + "]").
            html();
        
        if (options_modal) {
          vehicleModelModal.html(options_modal);
          vehicleModelModal.prop("disabled", false);
        } 
        
        else {
          vehicleModelModal.empty();
          vehicleModelModal.prop("disabled", true);
        }
      });
});