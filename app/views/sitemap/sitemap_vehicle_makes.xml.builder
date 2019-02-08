xml.instruct!

xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  
  xml.url do
    xml.loc vehicle_makes_url
    xml.changefreq("daily")
    xml.priority "0.7"
  end
  
  VehicleMake.all.each do |vehicle_make|
  
    xml.url do
      xml.loc posts_vehicle_make_url(vehicle_make)
      xml.changefreq("daily")
      xml.priority "0.7"
    end
    
    xml.url do
      xml.loc discussions_vehicle_make_url(vehicle_make)
      xml.changefreq("daily")
      xml.priority "0.7"
    end
  end
end