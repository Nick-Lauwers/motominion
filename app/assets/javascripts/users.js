$(function() {
  
  // edit_form
  
    // image preview
    
      var uploadedPhoto = $('.uploaded-photo');
      var uploadHidden  = $('.upload-hidden');
      
      function readURL(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();
        
          reader.onload = function (e) {
            uploadedPhoto.attr('src', e.target.result);
            $('.btn-profile-pic').prop("disabled", false);
          };
      
          reader.readAsDataURL(input.files[0]);
        }
      }
      
      uploadHidden.change(function(){
        readURL(this);
      });
  
  // show
  
    $(window).on('scroll', function() {
        
      // fixed info
      
        var profileScrolled = $('#profile-scrolled');

        profileScrolled.stick_in_parent({ offset_top: 50 });
    });

    // smooth scroll
    
      var reviewsScrolledButton = $(".btn-secondary-scrolled")
      
      reviewsScrolledButton.click(function(evn){
        evn.preventDefault();
        $('html, body').scrollTo(this.hash, this.hash); 
      });
  
  // shortlist
  
    // fixed map
      
      if ( $(window).width() > 768 ) {
        var fixedShortlistMap = $('.shortlist-map-container');
        fixedShortlistMap.stick_in_parent();
      }
      
    // mobile shortlist nav
      
      var shortlistNavGrid           = $('.shortlist-nav-grid');
      var shortlistNavMap            = $('.shortlist-nav-map');
      var shortlistNavGridIcon       = $('.shortlist-nav-grid-icon');
      var shortlistNavMapIcon        = $('.shortlist-nav-map-icon');
      var shortlistResults           = $('.shortlist-results');
      var shortlistResultsBackground = $('.shortlist-results-background');
      var shortlistMap               = $('#shortlist-map');
      var mapItem                    = $('.map-item');
      var marker                     = $('.marker');
      
      shortlistNavGrid.click(function() {
        
        if (shortlistNavGrid.hasClass('shortlist-nav-grid-inactive')) {
        	
        	shortlistNavGrid.
        	  removeClass('shortlist-nav-grid-inactive').
        	  addClass('shortlist-nav-grid-active');
        	  
        	shortlistNavMap.
        	  removeClass('shortlist-nav-map-active').
        	  addClass('shortlist-nav-map-inactive');
        	  
        	shortlistNavGridIcon.
        	  removeClass('shortlist-nav-grid-icon-inactive').
        	  addClass('shortlist-nav-grid-icon-active');
        	
        	shortlistNavMapIcon.
        	  removeClass('shortlist-nav-map-icon-active').
        	  addClass('shortlist-nav-map-icon-inactive');
        	  
        	mapItem.css("display", "none");
        	marker.css("background-image", "url('https://s3.us-east-2.amazonaws.com/online-dealership-assets/static-assets/map-marker-red.png')");

        	 
        	shortlistMap.css({"z-index": -1000});
        	shortlistResultsBackground.css({"display": "block"});
        	shortlistResults.height(shortlistResultsBackground.outerHeight());
        }
      });
    
      shortlistNavMap.click(function() {
        
        if (shortlistNavMap.hasClass('shortlist-nav-map-inactive')) {
        	
        	shortlistNavMap.
        	  removeClass('shortlist-nav-map-inactive').
        	  addClass('shortlist-nav-map-active');
        	  
        	shortlistNavGrid.
        	  removeClass('shortlist-nav-grid-active').
        	  addClass('shortlist-nav-grid-inactive');
        	  
        	shortlistNavMapIcon.
        	  removeClass('shortlist-nav-map-icon-inactive').
        	  addClass('shortlist-nav-map-icon-active');
        	
        	shortlistNavGridIcon.
        	  removeClass('shortlist-nav-grid-icon-active').
        	  addClass('shortlist-nav-grid-icon-inactive');
        	  
        	shortlistMap.css({"z-index": 1000});
        	shortlistResultsBackground.css({"display": "none"});
        	shortlistResults.height(shortlistMap.outerHeight());
        }
          
        else {
          
          shortlistNavMap.
        	  removeClass('shortlist-nav-map-active').
        	  addClass('shortlist-nav-map-inactive');
        	  
        	 shortlistNavGrid.
        	  removeClass('shortlist-nav-grid-inactive').
        	  addClass('shortlist-nav-grid-active');
        	  
        	shortlistNavMapIcon.
        	  removeClass('shortlist-nav-map-icon-active').
        	  addClass('shortlist-nav-map-icon-inactive');
        	 
        	shortlistNavGridIcon.
        	  removeClass('shortlist-nav-grid-icon-inactive').
        	  addClass('shortlist-nav-grid-icon-active');
        	  
        	mapItem.css("display", "none");
        	marker.css("background-image", "url('https://s3.us-east-2.amazonaws.com/online-dealership-assets/static-assets/map-marker-red.png')");

        	  
          shortlistMap.css({"z-index": -1000});
        	shortlistResultsBackground.css({"display": "block"});
        	shortlistResults.height(shortlistResultsBackground.outerHeight());
        }
      });
});