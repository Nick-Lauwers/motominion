xml.instruct!

xml.sitemapindex(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  
  xml.sitemap do
    xml.loc sitemap_nav_url(format: :xml)
    xml.lastmod Time.now.midnight.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
  end
  
  if Vehicle.where(id: 1..4999).any?
    xml.sitemap do
      xml.loc sitemap_vehicles_0_url(format: :xml)
      xml.lastmod Time.now.midnight.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
    end
  end
  
  if Vehicle.where(id: 5000..9999).any?
    xml.sitemap do
      xml.loc     sitemap_vehicles_1_url(format: :xml)
      xml.lastmod Time.now.midnight.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
    end
  end
  
  if Vehicle.where(id: 10000..14999).any?
    xml.sitemap do
      xml.loc     sitemap_vehicles_2_url(format: :xml)
      xml.lastmod Time.now.midnight.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
    end
  end
  
  if Vehicle.where(id: 15000..19999).any?
    xml.sitemap do
      xml.loc     sitemap_vehicles_3_url(format: :xml)
      xml.lastmod Time.now.midnight.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
    end
  end
  
  xml.sitemap do
    xml.loc     sitemap_vehicle_makes_url(format: :xml)
    xml.lastmod Time.now.midnight.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
  end
  
  xml.sitemap do
    xml.loc     sitemap_dealerships_url(format: :xml)
    xml.lastmod Time.now.midnight.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
  end
  
  xml.sitemap do
    xml.loc     sitemap_discussions_url(format: :xml)
    xml.lastmod Time.now.midnight.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
  end
  
  xml.sitemap do
    xml.loc     sitemap_posts_url(format: :xml)
    xml.lastmod Time.now.midnight.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
  end
  
  xml.sitemap do
    xml.loc     sitemap_clubs_url(format: :xml)
    xml.lastmod Time.now.midnight.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
  end
end