class ClubProductsController < ApplicationController
  
  before_action :logged_in_user,   except: [:show, :index]
  before_action :get_club,         only:   [:new, :create, :index]
  before_action :get_club_product, only:   [:show]
  
  # before_action :profile_pic, :club_admin
  
  def new
    # @club_product = @club.club_products.build
  end
  
  def create
    
    @club_product = @club.club_products.build(club_product_params)
    
    if @club_product.save
      
      if params[:images]
        params[:images].each do |image|
          @club_product.club_product_photos.create(image: image)
        end
      end
      
      @club_product_photos = @club_product.club_product_photos
      flash[:success] = "Product has been posted"
      redirect_to [@club, @club_product]
    
    else
      render 'new'
    end
  end
  
  def update
  end
  
  def show
  end
  
  def index
  end
  
  private
  
    def club_product_params
      params.require(:club_product).permit(:name, :price, :description, 
                                           :shipping_info)
    end
  
    # Before filters
    
    # Identifies autopart id
    
    def get_club
      @club = Club.find(params[:club_id])
    end
    
    def get_club_product
      @club_product = ClubProduct.find(params[:id])
    end
end
