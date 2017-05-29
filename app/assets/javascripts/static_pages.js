$(function() {
  
  // home
  
    // dependent dropdown
    
      var vehicleModelSelect = 
        $('#vehicle_vehicle_model_id.form-control.search-select-secondary');
      var vehicleMakeSelect =
        $('#vehicle_vehicle_make_id.form-control.search-select-primary');
      var vehicle_models = vehicleModelSelect.html();
        
      vehicleModelSelect.prop("disabled", true);
      
      vehicleMakeSelect.change(function() {
        
        var vehicle_make = 
          $('#vehicle_vehicle_make_id.form-control.search-select-primary :selected').
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
    
    // infinite scroll
    
      var pagination = $('#feed .pagination')
  
      if (pagination.length) {
        
        $(window).scroll(function() {
          
          var url = $('#feed .pagination .next_page a').attr('href');
          
          if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 1000) {
            pagination.text("Loading more vehicles...");
            $.getScript(url);
          }
        });
        
        $(window).scroll();
      }
      
    // smooth scroll
      
      // var popularSearchesLink = $(".popular-searches a")
      
      // popularSearchesLink.click(function(evn){
      //   evn.preventDefault();
      //   $('html, body').scrollTo(this.hash, this.hash, { offset: -50 }); 
      // });
});