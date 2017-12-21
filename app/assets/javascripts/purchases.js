$(function() {
  
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