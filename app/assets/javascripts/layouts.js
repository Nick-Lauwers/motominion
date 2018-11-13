$(function() {
  
  // general
  
    // floating action button
      
        var actionButton = $('.action-button');
      
        actionButton.on('click', function(){
          $(this).toggleClass('active');
        })

  // header-secondary
  
    // search bar
    
      var icon  = $('.header-icon-search-bar');
      var form  = $('.search-form-secondary');
      var close = $('.search-bar-secondary-close');
      
      icon.click(function() {
        form.fadeIn(300);
      });
      
      close.click(function() {
        form.fadeOut(300);
      });
      
    // modal
    
      var headerIconSearch = $('.header-icon-search');
      var headerIconMenu   = $('.header-icon-menu');
      var modalSearch      = $('#modal-search');
      var modalMenu        = $('#modal-menu');
      
      headerIconSearch.click(function() {
        
        if (headerIconSearch.hasClass('header-icon-inactive')) {
          headerIconSearch.removeClass('header-icon-inactive').addClass('header-icon-active');
          headerIconMenu.removeClass('header-icon-active').addClass('header-icon-inactive');
        	modalSearch.modal('show');
        	modalMenu.modal('hide');
        }
        
        else {
          headerIconSearch.removeClass('header-icon-active').addClass('header-icon-inactive');
        	modalSearch.modal('hide');
        }
      });
      
      headerIconMenu.click(function() {
        
        if (headerIconMenu.hasClass('header-icon-inactive')) {
        	headerIconSearch.removeClass('header-icon-active').addClass('header-icon-inactive');
          headerIconMenu.removeClass('header-icon-inactive').addClass('header-icon-active');
        	modalSearch.modal('hide');
        	modalMenu.modal('show');
        }
        
        else {
          headerIconMenu.removeClass('fa-close header-icon-active').addClass('fa-bars header-icon-inactive');
        	modalMenu.modal('hide');
        }
      });

  // contact widget
  
    var enquiryButton            = $('.btn-enquiry');
    var contactWidgetVisible     = $('.contact-widget-visible');
    var contactWidgetClose       = $('.contact-widget-close');
    var contactWidgetHidden      = $('.contact-widget-hidden');
    var contactWidgetPhone       = $('.contact-widget-phone');
    var contactWidgetMail        = $('.contact-widget-mail');
    var contactWidgetPhoneIcon   = $('.contact-widget-phone-icon');
    var contactWidgetMailIcon    = $('.contact-widget-mail-icon');
    var contactWidgetHiddenPhone = $('#contact-widget-hidden-phone');
    var contactWidgetHiddenMail  = $('#contact-widget-hidden-mail');
    
    enquiryButton.click(function(){
      enquiryButton.fadeOut(250);
      contactWidgetVisible.delay(250).fadeIn(250);
    });
    
    contactWidgetClose.click(function(){
      
      contactWidgetVisible.fadeOut(250);
      contactWidgetHidden.fadeOut(250);
      
      contactWidgetPhone.
    	  removeClass('contact-widget-phone-active').
    	  addClass('contact-widget-phone-inactive');

      contactWidgetMail.
    	  removeClass('contact-widget-mail-active').
    	  addClass('contact-widget-mail-inactive');
    	
    	contactWidgetPhoneIcon.
    	  removeClass('contact-widget-phone-icon-active').
    	  addClass('contact-widget-phone-icon-inactive');
    	  
    	contactWidgetMailIcon.
    	  removeClass('contact-widget-mail-icon-active').
    	  addClass('contact-widget-mail-icon-inactive');
    	  
      enquiryButton.delay(250).fadeIn(250);
    });
    
    contactWidgetPhone.click(function() {
      
      if (contactWidgetPhone.hasClass('contact-widget-phone-inactive')) {
      	
      	contactWidgetPhone.
      	  removeClass('contact-widget-phone-inactive').
      	  addClass('contact-widget-phone-active');
      	  
      	contactWidgetMail.
      	  removeClass('contact-widget-mail-active').
      	  addClass('contact-widget-mail-inactive');
      	  
      	contactWidgetPhoneIcon.
      	  removeClass('contact-widget-phone-icon-inactive').
      	  addClass('contact-widget-phone-icon-active');
      	
      	contactWidgetMailIcon.
      	  removeClass('contact-widget-mail-icon-active').
      	  addClass('contact-widget-mail-icon-inactive');
      	  
      	contactWidgetHiddenPhone.removeClass('hidden');
      	
      	contactWidgetHiddenMail.addClass('hidden');
      }
        
      else {
        
        contactWidgetPhone.
      	  removeClass('contact-widget-phone-active').
      	  addClass('contact-widget-phone-inactive');
      	  
      	contactWidgetPhoneIcon.
      	  removeClass('contact-widget-phone-icon-active').
      	  addClass('contact-widget-phone-icon-inactive');
      	  
      	contactWidgetHiddenPhone.addClass('hidden');
      }
    });
  
    contactWidgetMail.click(function() {
      
      if (contactWidgetMail.hasClass('contact-widget-mail-inactive')) {
      	
      	contactWidgetMail.
      	  removeClass('contact-widget-mail-inactive').
      	  addClass('contact-widget-mail-active');
      	  
      	contactWidgetPhone.
      	  removeClass('contact-widget-phone-active').
      	  addClass('contact-widget-phone-inactive');
      	  
      	contactWidgetMailIcon.
      	  removeClass('contact-widget-mail-icon-inactive').
      	  addClass('contact-widget-mail-icon-active');
      	
      	contactWidgetPhoneIcon.
      	  removeClass('contact-widget-phone-icon-active').
      	  addClass('contact-widget-phone-icon-inactive');
      	
      	contactWidgetHiddenMail.removeClass('hidden');
      	
      	contactWidgetHiddenPhone.addClass('hidden');
      }
        
      else {
        
        contactWidgetMail.
      	  removeClass('contact-widget-mail-active').
      	  addClass('contact-widget-mail-inactive');
      	  
      	contactWidgetMailIcon.
      	  removeClass('contact-widget-mail-icon-active').
      	  addClass('contact-widget-mail-icon-inactive');
      	  
      	contactWidgetHiddenMail.addClass('hidden');
      }
    });
});