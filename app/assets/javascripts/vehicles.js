$(function() {
  
  // modal
  
    // show modal after clicking hero-image or gallery-photo
      var heroListing   = $('.hero-listing');
      var galleryPhoto  = $('.gallery-photo');
      var modalGallery  = $('#modal-gallery');
      var modalCarousel = $('#modal-carousel');
      
      heroListing.click(function(){
        var idx = $(this).parents('div').index();
      	var id  = parseInt(idx);
      	
      	modalGallery.modal('show');
      	
      	var showInfo = $('.modal-show-info');
      	showInfo.height(optionsContainer.width());
      	
        modalCarousel.carousel(id);
      });
      
      galleryPhoto.click(function(){
        var idx = $(this).parents('div').index();
      	var id  = parseInt(idx);
      	
      	modalGallery.modal('show');
      	
      	var showInfo = $('.modal-show-info');
      	showInfo.height(optionsContainer.width());
      	
        modalCarousel.carousel(id);
      });
      
    // load photos into carousel
      var galleryPhoto = $('.gallery-photo');
      
      galleryPhoto.on('load', function() {}).each(function(i) {
        
        if(this.complete) {
          
        	var item    = $('<div class="item"></div>');
          var itexsiv = $(this).parents('div');
          var caption = $(this).parent('a').attr("caption");
          
          item.attr("caption",caption);
        	$(itexsiv.html()).appendTo(item);
        	item.appendTo('.carousel-inner'); 
        	
          if (i==0){
            item.addClass('active');
            item.addClass('modal-image');
          }
        }
      });
    
    // activate carousel
      var modalCarousel = $('#modal-carousel');
      
      modalCarousel.carousel({interval:false});
      
      // change caption when slide changes
      var modalCarousel = $('#modal-carousel');
      var modalCaption  = $('.modal-caption');
      
      modalCarousel.on('slid.bs.carousel', function () {
        modalCaption.html($(this).find('.active img').attr("caption"));
      });
      
    // image scaling
      var modalAvatar = $('.modal-avatar');
      
      modalAvatar.imagefill();
      
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
  
    // fixed map
    var fixedMap = $('#search-map');
    
    fixedMap.stick_in_parent({ offset_top: 50 });
  
  // show
  
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
});