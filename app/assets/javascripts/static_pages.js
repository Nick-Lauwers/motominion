$(function() {
  
  // home
    
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