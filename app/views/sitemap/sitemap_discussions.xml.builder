xml.instruct!

xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  Discussion.all.each do |discussion|
    xml.url do
      xml.loc discussion_url(discussion)
      xml.changefreq("daily")
      xml.priority "0.7"
    end
  end
end