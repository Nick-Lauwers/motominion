xml.instruct!

xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do

  xml.url do
    xml.loc root_url
    xml.changefreq("daily")
    xml.priority "1.0"
  end
  
  xml.url do
    xml.loc about_url
    xml.changefreq("weekly")
    xml.priority "0.7"
  end
  
  xml.url do
    xml.loc tour_url
    xml.changefreq("weekly")
    xml.priority "0.7"
  end
  
  xml.url do
    xml.loc how_it_works_url
    xml.changefreq("weekly")
    xml.priority "0.7"
  end
  
  xml.url do
    xml.loc new_enquiry_url
    xml.changefreq("weekly")
    xml.priority "0.7"
  end
end