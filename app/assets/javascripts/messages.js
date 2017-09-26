$(function() { 
  
  // index

    // expand description
    
      var recipientDescription     = $('.recipient-description');
      var recipientExpand          = $('.recipient-expand');
      var descriptionInitialHeight = 25;
  
      recipientDescription.each(function() {
        $.data(this, "realHeight", $(this).height());
      }).css({ overflow: "hidden", height: descriptionInitialHeight + 'px' });
      
      recipientExpand.click(function(e) {
        e.preventDefault();
        
        if (recipientDescription.hasClass("toggled")) {
          recipientDescription.animate({ 
            height: descriptionInitialHeight
          }, 600).removeClass("toggled");
          recipientExpand.html("+ More");
        } 
        
        else {
          recipientDescription.animate({ 
            height: recipientDescription.data("realHeight") 
          }, 600).addClass("toggled");
          recipientExpand.html("- Less");
        }
      });
});