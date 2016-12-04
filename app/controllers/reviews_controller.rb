# complete

class ReviewsController < ApplicationController
  
  def create
    @review = current_user.reviews.create(review_params)
    redirect_to @review.vehicle
  end
  
  def destroy
    @review = Review.find(params[:id])
    vehicle = @review.vehicle
    @review.destroy
    redirect_to vehicle
  end
  
  private
    def review_params
      params.require(:review).permit(:title, :comment, :star, :vehicle_id)
    end
end