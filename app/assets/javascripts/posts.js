$(function() { 
  
  // show
  
    // image scaling
    
      var postAvatar         = $('.post-avatar');
      var postResponseAvatar = $('.post-response-avatar')
          
      postAvatar.imagefill(); 
      postResponseAvatar.imagefill();
  
  // index
  
    // image scaling
    
      var topContributorAvatar = $('.top-contributor-avatar')
          
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
      var forumItemAvatar = $('.forum-item-avatar');
      
      forumSearchAvatar.imagefill(); 
      forumItemAvatar.imagefill(); 
});