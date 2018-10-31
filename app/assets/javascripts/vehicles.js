$(function() {
  
    // mobile search nav
      
      var searchNavGrid           = $('.search-nav-grid');
      var searchNavMap            = $('.search-nav-map');
      var searchNavGridIcon       = $('.search-nav-grid-icon');
      var searchNavMapIcon        = $('.search-nav-map-icon');
      var searchResults           = $('.search-results');
      var searchResultsBackground = $('.search-results-background');
      var searchMap               = $('#search-map');
      
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
        	 
        	searchMap.css({"z-index": -1000});
        	searchResultsBackground.css({"display": "block"});
        	searchResults.height(searchResultsBackground.outerHeight() + 50);
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
        	searchResults.height(searchMap.outerHeight() + 50);
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
        	  
          searchMap.css({"z-index": -1000});
        	searchResultsBackground.css({"display": "block"});
        	searchResults.height(searchResultsBackground.outerHeight() + 50);
        }
      });
});