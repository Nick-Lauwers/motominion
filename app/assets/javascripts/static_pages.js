$(function() {
  
  // home
    
    // smooth scroll
      var popularSearchesLink = $(".popular-searches a")
      
      popularSearchesLink.click(function(evn){
        evn.preventDefault();
        $('html, body').scrollTo(this.hash, this.hash, { offset: -50 }); 
      });
});