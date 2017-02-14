# completed
# Check order of reviews

class ReviewsController < ApplicationController
  
  def index
    @reviews = Review.where(reviewed_id: current_user.id)
  end
  
  def create
    
    @review = current_user.authored_reviews.create(review_params)
    
    if @review.save
      flash[:success] = "Review posted!"
      redirect_to @review.vehicle
    else
      flash[:failure] = "Please include all details."
      redirect_to @review.vehicle
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    vehicle = @review.vehicle
    @review.destroy
    redirect_to vehicle
  end
  
  private
    def review_params
      params.require(:review).permit(:title, :comment, :rating, :vehicle_id, 
                                     :reviewed_id)
    end
end