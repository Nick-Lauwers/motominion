$(function() {
  
  // home
  
    // dependent dropdown
    
      var vehicleModelSearch   = $('#vehicle-model-search');
      var vehicleMakeSearch    = $('#vehicle-make-search');
      var vehicle_model_search = vehicleModelSearch.html();
        
      vehicleModelSearch.prop("disabled", true);
      
      vehicleMakeSearch.change(function() {
        
        var vehicle_make_search = $('#vehicle-make-search :selected').text();
        var escaped_vehicle_make_search = 
          vehicle_make_search.
            replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
        var options_search = 
          $(vehicle_model_search).
            filter("optgroup[label=" + escaped_vehicle_make_search + "]").
            html();
        
        if (options_search) {
          vehicleModelSearch.html(options_search);
          vehicleModelSearch.prop("disabled", false);
        } 
        
        else {
          vehicleModelSearch.empty();
          vehicleModelSearch.prop("disabled", true);
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
      
      // var popularSearchesLink = $(".popular-searches a")
      
      // popularSearchesLink.click(function(evn){
      //   evn.preventDefault();
      //   $('html, body').scrollTo(this.hash, this.hash, { offset: -50 }); 
      // });
});