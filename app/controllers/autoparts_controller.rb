class AutopartsController < ApplicationController
  
  before_action :logged_in_user,     except: [:show]
  before_action :profile_pic_upload, only:   [:new]
  before_action :get_autopart,       only:   [:destroy, :show, :edit, :update, 
                                              :favorite, :sold, :undo_sold, 
                                              :bump]
  
  def new
    @autopart = current_user.autoparts.build
    @complete = "22%"
  end

  def create
    
    @autopart = current_user.autoparts.build(autopart_params)
    
    if @autopart.save
      
      if params[:images]
        params[:images].each do |image|
          @autopart.autopart_photos.create(image: image)
        end
      end
      
      @autopart_photos = @autopart.autopart_photos
      flash[:success] = "Part has been posted and bumped!"
      redirect_to autoparts_path
    
    else
      render 'new'
    end
  end

  def edit
    
    if current_user.id == @autopart.user.id
      @autopart_photos = @autopart.autopart_photos
      @complete = "100%"
    
    else
      flash[:danger] = "Access denied"
      redirect_to_back_or_default
    end
  end

  def update
    if @autopart.update(autopart_params)
      
      if params[:images]
        params[:images].each do |image|
          @autopart.autopart_photos.create(image: image)
        end
      end
      
      flash[:success] = "Part has been updated and bumped!"
      redirect_to autoparts_path
    
    else
      # flash[:danger] = "Please provide all information for this vehicle."
      render 'edit'
    end
  end

  def index
    @autoparts = current_user.autoparts
  end

  def show
    @photos = @autopart.autopart_photos
  end
  
  def favorite
    
    if current_user.favorite_autoparts.exists?(autopart_id: @autopart.id)
      flash[:failure] = "#{ @autopart.listing_name } has already been added to 
                         your wishlist!"
    
    else
      current_user.favorites << @autopart
      flash[:success] = 
        "#{ @autopart.listing_name } was added to your wishlist!"
    end
    
    redirect_to :back
  end
   
  def sold
    @autopart.update_attribute(:sold_at, Time.now)
    flash[:success] = "#{ @autopart.listing_name } has been marked as sold!"
    redirect_to :back
  end
  
  def undo_sold
    @autopart.update_attribute(:sold_at, nil)
    flash[:success] = 
      "#{ @autopart.listing_name } is now available for purchase!"
    redirect_to :back
  end
  
  def bump
    @autopart.update_attribute(:bumped_at, Time.now)
    flash[:success] = "#{ @autopart.listing_name } has been bumped!"
    redirect_to :back
  end
  
  private
  
    def autopart_params
      params.require(:autopart).permit(:listing_name, :street_address, 
                                       :apartment, :city, :state, :price, 
                                       :summary, :shipping_info, :bumped_at)
    end
  
    # Before filters
    
    # Identifies autopart id
    def get_autopart
      @autopart = Autopart.find(params[:id])
    end
end