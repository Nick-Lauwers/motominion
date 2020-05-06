class SitemapController < ApplicationController
  # respond_to :xml
  
  def index
    respond_to do |format|
      format.xml { render :layout => false }
    end
  end
  
  def sitemap_nav
    respond_to do |format|
      format.xml { render :layout => false }
    end
  end
  
  def sitemap_vehicles
  end
  
  def sitemap_vehicle_makes
  end
  
  def sitemap_discussions
  end
  
  def sitemap_posts
  end
  
  def sitemap_dealerships
  end
  
  def sitemap_clubs
  end
end