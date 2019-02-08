xml.instruct!

xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do

  xml.url do
    xml.loc new_dealership_url
    xml.changefreq("weekly")
    xml.priority "0.7"
  end

  Dealership.all.each do |dealership|
  
    xml.url do
      xml.loc dealership_url(dealership)
      xml.changefreq("daily")
      xml.priority "0.7"
    end
    
    xml.url do
      xml.loc vehicles_dealership_url(dealership)
      xml.changefreq("daily")
      xml.priority "0.7"
    end

    xml.url do
      xml.loc reviews_dealership_url(dealership)
      xml.changefreq("daily")
      xml.priority "0.7"
    end
  end
end