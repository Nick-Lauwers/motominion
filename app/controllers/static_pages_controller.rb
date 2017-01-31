# complete

class StaticPagesController < ApplicationController
  def home
    @feed_items = Vehicle.all
  end

  def help
  end
  
  def about
  end
  
  def how_it_works
  end
  
  def legal
  end
end

# remove home from static pages