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
  
  def sitemap_vehicles_0
    @vehicles = Vehicle.where(id: 1..4999).all
  end
  
  def sitemap_vehicles_1
    @vehicles = Vehicle.where(id: 5000..9999).all
  end
  
  def sitemap_vehicles_2
    @vehicles = Vehicle.where(id: 10000..14999).all
  end
  
  def sitemap_vehicles_3
    @vehicles = Vehicle.where(id: 15000..19999).all
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