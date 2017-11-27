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
     
    // clubPicUpload.change(function(){
    //   readURL(this);
    // });
  
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
});

// var ready = function () {

//     /**
//     * When the send message link on our home page is clicked
//     * send an ajax request to our rails app with the sender_id and
//     * recipient_id
//     */

//     $('.btn-navbar-contact-hidden').click(function (e) {
//         e.preventDefault();

//         var sender_id    = $(this).data('sid');
//         var recipient_id = $(this).data('rip');

//         $.post("/conversations", 
//               { sender_id: sender_id, recipient_id: recipient_id }, 
//               function (data) {
//                 chatBox.chatWith(data.conversation_id);
//               });
//         });

//     /**
//     * Used to minimize the chatbox
//     */

//     $(document).on('click', '.toggleChatBox', function (e) {
//         e.preventDefault();

//         var id = $(this).data('cid');
//         chatBox.toggleChatBoxGrowth(id);
//     });

//     /**
//     * Used to close the chatbox
//     */

//     $(document).on('click', '.closeChat', function (e) {
//         e.preventDefault();

//         var id = $(this).data('cid');
//         chatBox.close(id);
//     });


//     /**
//     * Listen on keypress' in our chat textarea and call the
//     * chatInputKey in chat.js for inspection
//     */

//     $(document).on('keydown', '.chatboxtextarea', function (event) {

//         var id = $(this).data('cid');
//         chatBox.checkInputKey(event, $(this), id);
//     });

//     /**
//     * When a conversation link is clicked show up the respective
//     * conversation chatbox
//     */

//     $('a.conversation').click(function (e) {
//         e.preventDefault();

//         var conversation_id = $(this).data('cid');
//         chatBox.chatWith(conversation_id);
//     });


// }

// $(document).ready(ready);
// $(document).on("page:load", ready);