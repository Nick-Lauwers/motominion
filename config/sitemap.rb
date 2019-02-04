SitemapGenerator::Sitemap.default_host = 'http://www.motominion.com'

SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new( 
  fog_provider:          'AWS',
  fog_directory:         ENV["S3_BUCKET_NAME"],
  aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
  aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
  fog_region:            ENV["AWS_REGION"]
)

SitemapGenerator::Sitemap.sitemaps_host = "https://#{ENV["S3_BUCKET_NAME"]}.s3.amazonaws.com"

SitemapGenerator::Sitemap.create do
  
  Vehicle.find_each do |vehicle|
   add vehicle_path(vehicle), :changefreq
  end
  
  # Project.find_each do |project|
  # add project_path(project, locale: :en)
  # add project_path(project, locale: :nl)
  # end
  # Page.find_each do |page|
  # add page_path(page, locale: :en)
  # add page_path(page, locale: :nl)
  # end

  # add "en/single-page"
  # add "nl/single-page"
  # add "nl/starters-website"
  # add "en/starters-website"
  # add "nl/website-op-maat"
  # add "en/website-op-maat"
  # add "nl/webapplicatie"
  # add "en/webapplicatie"
  # add "nl/website-analyse"
  # add "en/website-analyse"
end

# SitemapGenerator::Sitemap.create do
#   add '/home', :changefreq => 'daily', :priority => 0.9
#   add '/contact_us', :changefreq => 'weekly'
# end

SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks