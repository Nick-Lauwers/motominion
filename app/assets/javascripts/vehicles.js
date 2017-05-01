$(function() {
  
  // new
  
    // dependent dropdown
  
      var vehicleModelSelect = 
        $('#vehicle_vehicle_model_id.form-control.select-secondary');
      var vehicleMakeSelect =
        $('#vehicle_vehicle_make_id.form-control.select-secondary');
      var vehicle_models = vehicleModelSelect.html();
        
      vehicleModelSelect.prop("disabled", true);
      
      vehicleMakeSelect.change(function() {
        
        var vehicle_make = 
          $('#vehicle_vehicle_make_id.form-control.select-secondary :selected').
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

  // show
  
    // fixed-ribbon
    
      var ribbonVehicle = $('.ribbon-vehicle')
      
      $(window).scroll(function() { 
        
        var scrolltop = $(this).scrollTop();
        
        if(scrolltop >= 50) {
          ribbonVehicle.addClass('ribbon-vehicle-scrolled');
        }
        
        else {
          ribbonVehicle.removeClass('ribbon-vehicle-scrolled');
        }
      });
  
    // fixed listing navbar
    
      var listingNavbar       = $('.listing-navbar');
      var price               = $('.navbar-price-visible');
      var contactSellerButton = $('.btn-navbar-contact-hidden');
    
      $(window).scroll(function() {
        
        var scrolltop = $(this).scrollTop();
        
        if(scrolltop >= 480) {
          listingNavbar.addClass('listing-navbar-scrolled');
          price.addClass('navbar-price-hidden');
          contactSellerButton.addClass('btn-navbar-contact-visible');
        }
        
        else {
          listingNavbar.removeClass('listing-navbar-scrolled');
          price.removeClass('navbar-price-hidden');
          contactSellerButton.removeClass('btn-navbar-contact-visible');
        }
      });
  
    // smooth scroll navbar
    
      var listingNavbarLink = $('.listing-navbar li a');
      
      listingNavbarLink.click(function(evn){
          evn.preventDefault();
          $('html,body').scrollTo(this.hash, this.hash); 
      });
      
    // active navbar anchors
    
      var listingNavbarAnchor = $(".listing-navbar li")
      var aChildren           = listingNavbarAnchor.children();
      var aArray              = [];
      
      for (var i=0; i < aChildren.length; i++) { 
        
        var aChild = aChildren[i];
        var ahref  = $(aChild).attr('href');
        
        aArray.push(ahref);
      }
    
      $(window).scroll(function(){
        
        var windowPos     = $(window).scrollTop();
        var windowHeight  = $(window).height();
        var docHeight     = $(document).height();
    
        for (var i=0; i < aArray.length; i++) {
          var theID     = aArray[i];
          var divPos    = ( $(theID).offset().top - 1 );
          var divHeight = $(theID).height();
          
          if (windowPos >= divPos && windowPos < (divPos + divHeight)) {
            $("a[href='" + theID + "']").addClass("nav-active");
          } 
          else {
            $("a[href='" + theID + "']").removeClass("nav-active");
          }
        }
      });
  
    // image scaling
    
      var vehicleOverviewAvatar = $('.vehicle-overview-avatar');
      var galleryPhotoContainer = $('.gallery-photo-container');
        
      vehicleOverviewAvatar.imagefill();
      galleryPhotoContainer.imagefill();
      
    // fixed links
    
      var linksScrolled = $('#vehicle-scrolled');
      
      linksScrolled.stick_in_parent({ offset_top: 50 });
  
  // modal
  
    // show modal after clicking hero-image or gallery-photo
    
      var heroListing   = $('.hero-listing');
      var modalGallery  = $('#modal-gallery');
      var modalAvatar   = $('.modal-avatar');
      var galleryPhoto  = $('.gallery-photo');
      var showInfo      = $('.modal-show-info');
      var modalCarousel = $('#modal-carousel');
      
      heroListing.click(function(){
      	modalGallery.modal('show');
      	modalAvatar.imagefill();
      });
      
      galleryPhoto.click(function(){
      	modalGallery.modal('show');
      	modalAvatar.imagefill();
      });
      
    // expand caption
    
      var showInfo         = $('.modal-show-info');
      var showInfoText     = $('.show-info-text')
      var imageContainer   = $('.modal-carousel-container');
      var captionContainer = $('.modal-caption-container');
      
      showInfo.click(function(e) {
        e.preventDefault();
        
        if (imageContainer.hasClass('modal-carousel-container-closed')) {
          showInfoText.html("+ Info");
          imageContainer.removeClass('modal-carousel-container-closed');
          captionContainer.removeClass('modal-caption-container-open');
        } 
        
        else {
          showInfoText.html("- Hide");
          imageContainer.addClass('modal-carousel-container-closed');
          captionContainer.addClass('modal-caption-container-open');
        }
      });
      
  // search
    
    var vehicleTypeahead = $('#vehicle.typeahead');
    var cityTypeahead    = $('#city.typeahead');
  
    var vehicles = new Bloodhound({
      
      datumTokenizer: function(d) {
        return Bloodhound.tokenizers.whitespace(d.listing_name);
      },
      
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      
      remote: {
        url: '../vehicles/autocomplete?vehicle=%QUERY',
        wildcard: '%QUERY'
      }
    });
    
    var cities = new Bloodhound({
      
      datumTokenizer: function(d) {
        return Bloodhound.tokenizers.whitespace(d.city);
      },
      
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      
      remote: {
        url: '../vehicles/autocomplete?vehicle=%QUERY',
        wildcard: '%QUERY'
      }
    });
  
    vehicles.initialize();
    cities.initialize();
    
    vehicleTypeahead.typeahead(null, {
      name:       'vehicles',
      displayKey: 'listing_name',
      source:     vehicles.ttAdapter()
    });
    
    cityTypeahead.typeahead(null, {
      name:       'city',
      displayKey: 'city',
      source:     cities.ttAdapter()
    });
    
    
});