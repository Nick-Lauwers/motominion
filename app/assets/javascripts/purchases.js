$(function() {
  
  // new
    
    // purchase introduction
      
      var purchaseIntroductionClose = $('.purchase-introduction-close');
      var purchaseIntroduction      = $('.purchase-introduction');
      
      purchaseIntroductionClose.click(function () {
        purchaseIntroduction.css("display", "none");
      });
  
  // financial
  
    // datetimepicker
    
      var purchaseDOB = $('#purchase-dob');
      
      $(function () {
        purchaseDOB.datetimepicker({
          format:            'DD/MM/YYYY',
          widgetPositioning: { horizontal: 'auto', vertical: 'bottom' }
        });
      });
});