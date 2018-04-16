$(function() {
  
  // new
  
    // dependent dropdown
    
      var vehicleModelNew   = $('#vehicle-model-new');
      var vehicleMakeNew    = $('#vehicle-make-new');
      var vehicle_model_new = vehicleModelNew.html();
        
      vehicleModelNew.prop("disabled", true);
      
      vehicleMakeNew.change(function() {
        
        var vehicle_make_new = $('#vehicle-make-new :selected').text();
        var escaped_vehicle_make_new = 
          vehicle_make_new.
            replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
        var options_new = 
          $(vehicle_model_new).
            filter("optgroup[label=" + escaped_vehicle_make_new + "]").
            html();
        
        if (options_new) {
          vehicleModelNew.html(options_new);
          vehicleModelNew.prop("disabled", false);
        } 
        
        else {
          vehicleModelNew.empty();
          vehicleModelNew.prop("disabled", true);
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
            $("a[href='" + theID + "']").parent().addClass("nav-active");
          } 
          else {
            $("a[href='" + theID + "']").parent().removeClass("nav-active");
          }
        }
      });
    
    // dealer select modal
      
      var negotiateDealerButton  = $('.btn-negotiate-dealer')
      var modalDealerSelect      = $('#modal-dealer-select')
      var modalDealerSelectClose = $('.modal-dealer-select-close');
      
      negotiateDealerButton.click(function() {
        modalDealerSelect.modal('show');
      });
      
      modalDealerSelectClose.click(function() {
        modalDealerSelect.modal('hide');
      });  
      
    // buy online modal
  
      var buyOnlineButton     = $('.btn-buy-online')
      var modalBuyOnline      = $('#modal-buy-online')
      var modalBuyOnlineClose = $('.modal-buy-online-close');
      
      buyOnlineButton.click(function() {
        modalBuyOnline.modal('show');
      });
      
      modalBuyOnlineClose.click(function() {
        modalBuyOnline.modal('hide');
      }); 
  
    // image scaling
    
      var galleryPhotoContainer = $('.gallery-photo-container');
        
      galleryPhotoContainer.imagefill();
      
    // fixed links
    
      var linksScrolled = $('#vehicle-scrolled');
      
      linksScrolled.stick_in_parent({ offset_top: 50 });
      
    // appointment modal
    
      var modalAppointment            = $('#modal-appointment')
      var mobileAppointmentButton     = $('.btn-appointment-mobile')
      var modalAppointmentHeaderClose = $('.modal-appointment-header-close');
      
      mobileAppointmentButton.click(function() {
        modalAppointment.modal('show');
      });
      
      modalAppointmentHeaderClose.click(function() {
        modalAppointment.modal('hide');
      });
      
      var appointmentTimeModal = $('#appointment-time-modal');
      
      $(function () {
        appointmentTimeModal.datetimepicker({
          format:            'YYYY-MM-DD LT',
          minDate:           Date(),
          widgetPositioning: { horizontal: 'auto', vertical: 'bottom' }
        });
      });
  
  // modal
  
    // show modal after clicking hero-image or gallery-photo
    
      var heroListing   = $('.hero-listing');
      var modalGallery  = $('#modal-gallery');
      var galleryPhoto  = $('.gallery-photo');
      var modalCarousel = $('#modal-carousel');
      
      heroListing.click(function() {
      	modalGallery.modal('show');
      });
      
      galleryPhoto.click(function(){
      	modalGallery.modal('show');
      });
      
    // expand caption
    
      var showInfo         = $('.show-info');
      var showInfoText     = $('.show-info-text');
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
    
    // autocomplete
    
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
      
    // fixed map
      
      var fixedMap = $('#search-map');
     
      fixedMap.stick_in_parent({ offset_top: 50 });
      
    // search introduction
      
      var searchIntroductionStaticClose = $('.search-introduction-static-close');
      var searchIntroduction            = $('.search-introduction');
      
      searchIntroductionStaticClose.click(function () {
        searchIntroduction.css("display", "none");
      });
      
    // special offer modal
      
      var specialOffer           = $('.special-offer');
      var specialOfferButton     = $('.special-offer-button');
      var modalSpecialOffer      = $('#modal-special-offer');
      var modalSpecialOfferClose = $('.modal-special-offer-close');
      
      specialOffer.click(function() {
        var myVehicleId = $('.special-offer-button').data('id');
        $("#vehicleId").val(myVehicleId);
        
        // modalSpecialOffer.modal('show');
      });
      
      modalSpecialOfferClose.click(function() {
        modalSpecialOffer.modal('hide');
      });

  // basics
  
    // dependent dropdown
      
      var vehicleModelBasics   = $('#vehicle-model-basics');
      var vehicleMakeBasics    = $('#vehicle-make-basics');
      var vehicle_model_basics = vehicleModelBasics.html();
        
      vehicleModelBasics.prop("disabled", true);
      
      vehicleMakeBasics.change(function() {
        
        var vehicle_make_basics = $('#vehicle-make-basics :selected').text();
        var escaped_vehicle_make_basics = 
          vehicle_make_basics.
            replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
        var options_basics = 
          $(vehicle_model_basics).
            filter("optgroup[label=" + escaped_vehicle_make_basics + "]").
            html();
        
        if (options_basics) {
          vehicleModelBasics.html(options_basics);
          vehicleModelBasics.prop("disabled", false);
        } 
        
        else {
          vehicleModelBasics.empty();
          vehicleModelBasics.prop("disabled", true);
        }
      });
});