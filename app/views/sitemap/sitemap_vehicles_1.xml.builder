xml.instruct!

xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  Vehicle.where(id: 5000..9999).each do |vehicle|
    xml.url do
      xml.loc vehicle_url(vehicle)
      xml.changefreq("daily")
      xml.priority "0.7"
    end
  end
end