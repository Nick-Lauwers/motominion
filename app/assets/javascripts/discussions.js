$(function() { 
  
  // show
      
    // search
    
      var postTypeahead = $('#post.typeahead');

      var posts = new Bloodhound({
        
        datumTokenizer: function(d) {
          return Bloodhound.tokenizers.whitespace(d.title);
        },
        
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        
        remote: {
          url: '../posts/autocomplete?post=%QUERY',
          wildcard: '%QUERY'
        }
      });
    
      posts.initialize();
  
      postTypeahead.typeahead(null, {
        name:       'posts',
        displayKey: 'title',
        source:     posts.ttAdapter()
      });
      
  // new
  
    // dependent dropdown
      
      var vehicleModelDiscussion   = $('#vehicle-model-discussion');
      var vehicleMakeDiscussion    = $('#vehicle-make-discussion');
      var vehicle_model_discussion = vehicleModelDiscussion.html();
        
      vehicleModelDiscussion.prop("disabled", true);
      
      vehicleMakeDiscussion.change(function() {
        
        var vehicle_make_discussion = 
          $('#vehicle-make-discussion :selected').text();
        var escaped_vehicle_make_discussion = 
          vehicle_make_discussion.
            replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
        var options_discussion = 
          $(vehicle_model_discussion).
            filter("optgroup[label=" + escaped_vehicle_make_discussion + "]").
            html();
        
        if (options_discussion) {
          vehicleModelDiscussion.html(options_discussion);
          vehicleModelDiscussion.prop("disabled", false);
        } 
        
        else {
          vehicleModelDiscussion.empty();
          vehicleModelDiscussion.prop("disabled", true);
        }
      });
});