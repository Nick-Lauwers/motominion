$(function() { 
  
  // form
  
    // image scaling
    var messageAvatar = $('.message-avatar');
    
    messageAvatar.imagefill(); 
    
  // index
  
    // image scaling
    var messagesInfoAvatar = $('.messages-info-avatar');

    messagesInfoAvatar.imagefill();

    // expand description
    var description   = $('.messages-info-description');
    var expand        = $('.messages-info-expand');
    var initialHeight = 100;

    description.each(function() {
      $.data(this, "realHeight", $(this).height());
    }).css({ overflow: "hidden", height: initialHeight + 'px' });
    
    expand.click(function(e) {
      e.preventDefault();
      
      if (description.hasClass("toggled")) {
        description.animate({ 
          height: initialHeight
        }, 600).removeClass("toggled");
        expand.html("+ More");
      } 
      
      else {
        description.animate({ 
          height: description.data("realHeight") 
        }, 600).addClass("toggled");
        expand.html("- Less");
      }
    });
});