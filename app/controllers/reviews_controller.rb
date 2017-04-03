# completed
# Check order of reviews

class ReviewsController < ApplicationController
  
  def index
    @reviews_about_you = Review.where(reviewed_id: current_user.id)
    @reviews_by_you    = Review.where(reviewer_id: current_user.id)
    
    @reviews_about_you.each do |review|
      review.update_attribute(:read_at, Time.now)
    end
  end
  
  def create
    
    @review = current_user.authored_reviews.create(review_params)
    
    if @review.save
      ReviewMailer.review_received(@review).deliver_now
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