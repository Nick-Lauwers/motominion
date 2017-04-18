$(function() { 
  
  // show
  
    // image scaling
    
      var postAvatar     = $('.post-avatar');
      var responseAvatar = $('.response-avatar')
          
      postAvatar.imagefill(); 
      responseAvatar.imagefill();
  
  // index
  
    // image scaling
    
      var forumItemAvatar      = $('.forum-item-avatar');
      var topContributorAvatar = $('.top-contributor-avatar')
          
      forumItemAvatar.imagefill();
      topContributorAvatar.imagefill();
      
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
      
  // search
  
    // image scaling
    
      var forumSearchAvatar = $('.forum-search-avatar');
      
      forumSearchAvatar.imagefill(); 
});