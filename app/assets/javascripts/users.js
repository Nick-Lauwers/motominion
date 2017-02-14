$(function() {
  
  // edit_form
  
    // image preview
      var avatar       = $('.avatar');
      var avatarUpload = $('.avatar-upload')
      
      function readURL(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();
        
          reader.onload = function (e) {
            avatar.attr('src', e.target.result);
          };
      
          reader.readAsDataURL(input.files[0]);
        }
      }
      
     avatarUpload.change(function(){
          readURL(this);
      });
  
  // show
  
    $(window).on('scroll', function() {
        
      // fixed info
        var profileScrolled = $('#profile-scrolled');
        
        profileScrolled.stick_in_parent({ offset_top: 50 });
    });
    
    // parallax-scroll
      var scrollHeroImage = $('.hero-profile');
      
      scrollHeroImage.parallax ({
        imageSrc: '/assets/cover-photo.jpeg'
      });
      
    // image scaling
      var userSummaryAvatar   = $('.user-summary-avatar');

      userSummaryAvatar.imagefill();

    // smooth scroll
      var reviewsScrolledButton = $(".btn-secondary-scrolled")
      
      reviewsScrolledButton.click(function(evn){
        evn.preventDefault();
        $('html, body').scrollTo(this.hash, this.hash); 
      });
});