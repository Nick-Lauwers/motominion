$(function() {
  
  // home
  
    // dependent dropdown
    
      var vehicleModelHome   = $('#vehicle-model-home');
      var vehicleMakeHome    = $('#vehicle-make-home');
      var vehicle_model_home = vehicleModelHome.html();
        
      vehicleModelHome.prop("disabled", true);
      
      vehicleMakeHome.change(function() {
        
        var vehicle_make_home = $('#vehicle-make-home :selected').text();
        var escaped_vehicle_make_home = 
          vehicle_make_home.
            replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
        var options_home = 
          $(vehicle_model_home).
            filter("optgroup[label=" + escaped_vehicle_make_home + "]").
            html();
        
        if (options_home) {
          vehicleModelHome.html("<option value=''>All models</option>" + 
                                  options_home);
          vehicleModelHome.prop("disabled", false);
        } 
        
        else {
          vehicleModelHome.empty();
          vehicleModelHome.prop("disabled", true);
        }
      });
      
    // mobile search bar
    
      var heroMobileSearch = $('.hero-mobile-search');
      
      heroMobileSearch.click(function() {
      	modalSearch.modal('show');
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
      
      var personalizedSearchLink = $("a.personalized-search-link")
      
      personalizedSearchLink.click(function(evn){
        evn.preventDefault();
        $('html, body').scrollTo(this.hash, this.hash, { offset: -50 }); 
      });
});