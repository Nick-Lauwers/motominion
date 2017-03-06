$(function() {

  // header-secondary
  
    // search bar
    
      var search = $('.header-icon');
      var form   = $('.search-form-secondary');
      var close  = $('.search-bar-secondary-close');
      
      search.click(function() {
        form.fadeIn(300);
      });
      
      close.click(function() {
        form.fadeOut(300);
      });
    
  // hero-backend
  
    // image scaling
    
      var heroAvatar = $('.hero-avatar');
      
      heroAvatar.imagefill(); 
});