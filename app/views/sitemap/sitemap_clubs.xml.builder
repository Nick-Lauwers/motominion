xml.instruct!

xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  
  xml.url do
    xml.loc clubs_url
    xml.changefreq("daily")
    xml.priority "0.7"
  end
  
  Club.all.each do |club|
  
    xml.url do
      xml.loc posts_club_url(club)
      xml.changefreq("daily")
      xml.priority "0.7"
    end
    
    xml.url do
      xml.loc discussions_club_url(club)
      xml.changefreq("daily")
      xml.priority "0.7"
    end
  end
end