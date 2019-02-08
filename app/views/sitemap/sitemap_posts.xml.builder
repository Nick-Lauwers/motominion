xml.instruct!

xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  Post.all.each do |post|
    xml.url do
      xml.loc discussion_url(post)
      xml.changefreq("daily")
      xml.priority "0.7"
    end
  end
end