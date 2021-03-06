$(function() {
  
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
      var quote               = $('.navbar-quote-visible');
      var contactSellerButton = $('.btn-navbar-contact-hidden');
    
      $(window).scroll(function() {
        
        var scrolltop = $(this).scrollTop();
        
        if(scrolltop >= 480) {
          listingNavbar.addClass('listing-navbar-scrolled');
          price.addClass('navbar-price-hidden');
          quote.addClass('navbar-quote-hidden');
          contactSellerButton.addClass('btn-navbar-contact-visible');
        }
        
        else {
          listingNavbar.removeClass('listing-navbar-scrolled');
          price.removeClass('navbar-price-hidden');
          quote.removeClass('navbar-quote-hidden');
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
      
    // message banner
    
      var messageBanner = $('.message-banner');
    
      $(window).scroll(function() {
        
        var scrolltop = $(this).scrollTop();
        
        if(scrolltop >= 300 && scrolltop <= 1200) {
          messageBanner.fadeIn();
        }
        
        else {
          messageBanner.fadeOut();
        }
      });

    // expand description
    
      var vehicleOverviewDescription     = $('.vehicle-overview-description');
      var vehicleOverviewExpand          = $('.vehicle-overview-expand');

      function em(input) {
        var emSize = parseFloat($("body").css("font-size"));
        return (emSize * input);
      }
      
      if (vehicleOverviewDescription.height() >= em(10)) {
        
        vehicleOverviewDescription.each(function() {
          $.data(this, "realHeight", $(this).height());
        }).css({ overflow: "hidden", height: '10em' });
        
        vehicleOverviewExpand.css({display: "block"});
        
        vehicleOverviewExpand.click(function(e) {
          
          e.preventDefault();
          
          if (vehicleOverviewDescription.hasClass("toggled")) {
            vehicleOverviewDescription.animate({ 
              height: '10em'
            }, 600).removeClass("toggled");
            vehicleOverviewExpand.html("+ More");
          } 
          
          else {
            vehicleOverviewDescription.animate({ 
              height: vehicleOverviewDescription.data("realHeight") 
            }, 600).addClass("toggled");
            vehicleOverviewExpand.html("- Less");
          }
        });
      }

    // test drive modal  
      
      var appointmentButton          = $('.btn-appointment');
      var vehicleDetailsTestDrive    = $('.vehicle-details-test-drive');
      var modalTestDriveDesktop      = $('#modal-test-drive-desktop');
      var modalTestDriveMobile       = $('#modal-test-drive-mobile');
      var modalTestDriveDesktopClose = $('.modal-test-drive-desktop-close');
      var modalTestDriveMobileClose  = $('.modal-test-drive-mobile-close');
      
      appointmentButton.click(function() {
        modalTestDriveDesktop.modal('show');
      });
      
      vehicleDetailsTestDrive.click(function() {
        modalTestDriveMobile.modal('show');
      });
      
      modalTestDriveDesktopClose.click(function() {
        modalTestDriveDesktop.modal('hide');
      });  
      
      var appointmentTimeModal = $('#appointment-time-modal');
      
      $(function () {
        appointmentTimeModal.datetimepicker({
          format:            'YYYY-MM-DD LT',
          minDate:           Date(),
          widgetPositioning: { horizontal: 'auto', vertical: 'bottom' }
        });
      });

      var modalTestDriveLeft   = $('.modal-test-drive-left');
      var modalTestDriveRight  = $('.modal-test-drive-right');
      var modalTestDriveScroll = $('.modal-test-drive-scroll');
      
      modalTestDriveLeft.click(function() {
        
        event.preventDefault();
        
        modalTestDriveScroll.animate({
          scrollLeft: "-=300px"
        }, "slow");
      });
      
      modalTestDriveRight.click(function() {
        
        event.preventDefault();
        
        modalTestDriveScroll.animate({
          scrollLeft: "+=300px"
        }, "slow");
      });
      
    // dealer select modal
      
      var negotiateDealerButton    = $('.btn-negotiate-dealer');
      var modalDealerSelectDesktop = $('#modal-dealer-select-desktop');
      var modalDealerSelectMobile  = $('#modal-dealer-select-mobile');
      var modalDealerSelectClose   = $('.modal-dealer-select-close');
      var modalDealerSelectLeft    = $('.modal-dealer-select-left');
      var modalDealerSelectRight   = $('.modal-dealer-select-right');
      var modalDealerSelectScroll  = $('.modal-dealer-select-scroll');
      
      if ( $(window).width() > 768 ) {
        
        negotiateDealerButton.click(function() {
          modalDealerSelectDesktop.modal('show');
        });
        
        modalDealerSelectClose.click(function() {
          modalDealerSelectDesktop.modal('hide');
        });
        
        modalDealerSelectLeft.click(function() {
        
          event.preventDefault();
          
          modalDealerSelectScroll.animate({
            scrollLeft: "-=300px"
          }, "slow");
        });
        
        modalDealerSelectRight.click(function() {
          
          event.preventDefault();
          
          modalDealerSelectScroll.animate({
            scrollLeft: "+=300px"
          }, "slow");
        });
      }
      
      else {
        
        negotiateDealerButton.click(function() {
          modalDealerSelectMobile.modal('show');
        });
        
        modalDealerSelectClose.click(function() {
          modalDealerSelectMobile.modal('hide');
        });
      } 
      
    // buy online modal
  
      var buyOnlineButton        = $('.btn-buy-online');
      var vehicleDetailsPurchase = $('.vehicle-details-purchase');
      var modalBuyOnlineDesktop  = $('#modal-buy-online-desktop');
      var modalBuyOnlineMobile   = $('#modal-buy-online-mobile');
      var modalBuyOnlineClose    = $('.modal-buy-online-close');
      var modalBuyOnlineLeft     = $('.modal-buy-online-left');
      var modalBuyOnlineRight    = $('.modal-buy-online-right');
      var modalBuyOnlineScroll   = $('.modal-buy-online-scroll');
      
      buyOnlineButton.click(function() {
        modalBuyOnlineDesktop.modal('show');
      });
      
      vehicleDetailsPurchase.click(function() {
        modalBuyOnlineMobile.modal('show');
      });
      
      modalBuyOnlineClose.click(function() {
        
        if ( $(window).width() > 768 ) {
          modalBuyOnlineDesktop.modal('hide');
        }
        
        else {
          modalBuyOnlineMobile.modal('hide');
        }
      });
      
      modalBuyOnlineLeft.click(function() {
      
        event.preventDefault();
        
        modalBuyOnlineScroll.animate({
          scrollLeft: "-=300px"
        }, "slow");
      });
      
      modalBuyOnlineRight.click(function() {
        
        event.preventDefault();
        
        modalBuyOnlineScroll.animate({
          scrollLeft: "+=300px"
        }, "slow");
      });

    // image scaling
    
      var galleryPhotoContainer = $('.gallery-photo-container');
        
      galleryPhotoContainer.imagefill();
      
    // fixed links
    
      var linksScrolled = $('#vehicle-scrolled');
      
      linksScrolled.stick_in_parent({ offset_top: 50 });
  
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
      
      if ( $(window).width() > 768 ) {
        var fixedMap = $('.search-map-container');
        fixedMap.stick_in_parent({ offset_top: 50 });
      }

    // search introduction
      
      var searchIntroductionStaticClose = $('.search-introduction-static-close');
      var searchIntroduction            = $('.search-introduction');
      
      searchIntroductionStaticClose.click(function () {
        searchIntroduction.css("display", "none");
      });
    
    // mobile search nav
      
      var searchNavGrid           = $('.search-nav-grid');
      var searchNavMap            = $('.search-nav-map');
      var searchNavGridIcon       = $('.search-nav-grid-icon');
      var searchNavMapIcon        = $('.search-nav-map-icon');
      var searchResults           = $('.search-results');
      var searchResultsBackground = $('.search-results-background');
      var searchMapContainer      = $('.search-map-container');
      var searchMap               = $('#search-map');
      var footer                  = $('.footer');
      var mapItem                 = $('.map-item');
      var marker                  = $('.marker');
      
      searchNavGrid.click(function() {
        
        if (searchNavGrid.hasClass('search-nav-grid-inactive')) {
        	
        	searchNavGrid.
        	  removeClass('search-nav-grid-inactive').
        	  addClass('search-nav-grid-active');
        	  
        	searchNavMap.
        	  removeClass('search-nav-map-active').
        	  addClass('search-nav-map-inactive');
        	  
        	searchNavGridIcon.
        	  removeClass('search-nav-grid-icon-inactive').
        	  addClass('search-nav-grid-icon-active');
        	
        	searchNavMapIcon.
        	  removeClass('search-nav-map-icon-active').
        	  addClass('search-nav-map-icon-inactive');
        	  
        	mapItem.css("display", "none");
        	marker.css("background-image", "url('https://s3.us-east-2.amazonaws.com/online-dealership-assets/static-assets/map-marker-red.png')");
        	  
        	searchMap.css({"z-index": -1000});
        	searchResultsBackground.css({"display": "block"});
        	searchResults.height(searchResultsBackground.outerHeight());
        	footer.css("display", "block");
        }
      });
    
      searchNavMap.click(function() {
        
        if (searchNavMap.hasClass('search-nav-map-inactive')) {
        	
        	searchNavMap.
        	  removeClass('search-nav-map-inactive').
        	  addClass('search-nav-map-active');
        	  
        	searchNavGrid.
        	  removeClass('search-nav-grid-active').
        	  addClass('search-nav-grid-inactive');
        	  
        	searchNavMapIcon.
        	  removeClass('search-nav-map-icon-inactive').
        	  addClass('search-nav-map-icon-active');
        	
        	searchNavGridIcon.
        	  removeClass('search-nav-grid-icon-active').
        	  addClass('search-nav-grid-icon-inactive');
        	
        	searchMap.css({"z-index": 1000});
        	searchResultsBackground.css({"display": "none"});
        	searchResults.height(searchMap.outerHeight());
        	footer.css("display", "none");
        }
          
        else {
          
          searchNavMap.
        	  removeClass('search-nav-map-active').
        	  addClass('search-nav-map-inactive');
        	  
        	 searchNavGrid.
        	  removeClass('search-nav-grid-inactive').
        	  addClass('search-nav-grid-active');
        	  
        	searchNavMapIcon.
        	  removeClass('search-nav-map-icon-active').
        	  addClass('search-nav-map-icon-inactive');
        	 
        	searchNavGridIcon.
        	  removeClass('search-nav-grid-icon-inactive').
        	  addClass('search-nav-grid-icon-active');
        	  
        	mapItem.css("display", "none");
        	marker.css("background-image", "url('https://s3.us-east-2.amazonaws.com/online-dealership-assets/static-assets/map-marker-red.png')");

          searchMap.css({"z-index": -1000});
        	searchResultsBackground.css({"display": "block"});
        	searchResults.height(searchResultsBackground.outerHeight());
        	footer.css("display", "block");
        }
      });
});