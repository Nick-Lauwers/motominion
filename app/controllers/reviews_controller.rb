# complete

class ReviewsController < ApplicationController
  def create
    @review = current_user.authored_reviews.create(review_params)
    redirect_to @review.vehicle
    
    # if @review.save
    #   respond_to do |format|
    #     format.js
    #   end
    # end
    
    # if @review.save
    #   flash[:success] = "Review posted!"
    #   redirect_to @review.vehicle
    # else
    #   redirect_to @review.vehicle
    # end
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